package com.hellokoding.auth.web;

import com.hellokoding.auth.mapper.UserImageMapper;
import com.hellokoding.auth.mapper.UserMapper;
import com.hellokoding.auth.model.User;
import com.hellokoding.auth.model.UserImage;
import com.hellokoding.auth.service.SecurityService;
import com.hellokoding.auth.service.UserService;
import com.hellokoding.auth.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserImageMapper userImageMapper;


    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/welcome";
    }

    @GetMapping("/login")
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(HttpServletRequest request) {
        request.setAttribute("imageList", getImageListFromBackend(request));
        request.setAttribute("videoList", getVideoListFromBackend());

        return "welcome";
    }

    @RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
    public String imageUpload(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        // 处理上传的文件
        if (!file.isEmpty()) {
            try {
                // 获取文件名
                String fileName = file.getOriginalFilename();
                // 获取文件数据
                byte[] fileData = file.getBytes();

                // 在此处执行你希望进行的文件处理操作
                UserImage userImage = new UserImage();
                userImage.setImageData(fileData);
                userImage.setImageName(fileName);
                //get current User Info
                String userName = request.getUserPrincipal().getName();
                User user = userMapper.findByUsername(userName);
                userImage.setUserId(Integer.parseInt(String.valueOf(user.getId())));
                userService.insertImageData(userImage);

                return "redirect:/welcome";
            } catch (IOException e) {
                e.printStackTrace();
                return "redirect:/welcome";
            }
        } else {
            return "redirect:/welcome";
        }
    }

    private List<UserImage> getImageListFromBackend(HttpServletRequest request) {
        // 在这里编写获取图片列表数据的逻辑
        //get current User Info
        String userName = request.getUserPrincipal().getName();
        User user = userMapper.findByUsername(userName);

        List<UserImage> list = userImageMapper.findByUserId(user.getId());
        if (!CollectionUtils.isEmpty(list)) {
            for (UserImage userImage : list) {
                userImage.setImageBase64(Base64.getEncoder().encodeToString(userImage.getImageData()));
            }
        }
        return list;
    }

    private List<String> getVideoListFromBackend() {
        List<String> imageList = new ArrayList<>();
        // 添加图片URL到列表中
        imageList.add("video.mp4");
        imageList.add("video.mp4");
        imageList.add("video.mp4");
        return imageList;
    }
}
