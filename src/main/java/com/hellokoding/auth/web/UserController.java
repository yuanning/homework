package com.hellokoding.auth.web;

import com.hellokoding.auth.model.User;
import com.hellokoding.auth.service.SecurityService;
import com.hellokoding.auth.service.UserService;
import com.hellokoding.auth.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

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

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
//        if (error != null)
//            model.addAttribute("error", "Your username and password is invalid.");
//
//        if (logout != null)
//            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(HttpServletRequest request) {
        request.setAttribute("imageList", getImageListFromBackend());
        request.setAttribute("videoList", getVideoListFromBackend());
        return "welcome";
    }

    private List<String> getImageListFromBackend() {
        // 在这里编写获取图片列表数据的逻辑
        // 例如，从数据库、文件系统或其他数据源中获取数据
        List<String> imageList = new ArrayList<>();
        // 添加图片URL到列表中
        imageList.add("image.jpg");
        imageList.add("image.jpg");
        imageList.add("image.jpg");
        return imageList;
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
