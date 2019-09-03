package com.nicolas.ocp6.webapp.controllers;

import com.nicolas.ocp6.business.ServiceGuidebook;
import com.nicolas.ocp6.business.ServiceLogin;
import com.nicolas.ocp6.business.ServiceMember;
import com.nicolas.ocp6.model.bean.Guidebook;
import com.nicolas.ocp6.model.bean.Member;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import java.util.List;

import static com.nicolas.ocp6.business.Utils.firstLetterUpperCase;


@SessionAttributes(value = {"user", "guidebooksForLoan", "selectedGuidebook", "test"})
@Controller
public class ControllerLogin {

    @Autowired
    ServiceLogin serviceLogin;

    @Autowired
    ServiceGuidebook serviceGuidebook;

    @Autowired
    ServiceMember serviceMember;

    private static final Logger logger = LogManager.getLogger();



    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String displayloginPage(@RequestParam(value = "afterLogin") String jspAfterLogin,
                                   ModelMap model) {
        model.put("jspAfterLogin", jspAfterLogin);
        return "login";
    }


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String checkPassword(@RequestParam(value = "email") String inputEmail,
                                @RequestParam(value = "password") String inputPassword,
                                @RequestParam(value = "afterLogin") String jspAfterLogin,
                                ModelMap model) {

        Member user = serviceLogin.findMemberByEmail(inputEmail);

        if (user == null) {
            model.put("message", "memberNotFound");
            model.put("jspAfterLogin", jspAfterLogin);
            return "login";
        }

        if (serviceLogin.checkPassword(inputPassword, user)) {
            model.put("user", user);
            logger.info("quitte checkPassword");
            logger.info(model);
            return jspAfterLogin;

        } else {
            model.put("message", "wrongPassword");
            model.put("jspAfterLogin", jspAfterLogin);
            return "login";
        }
    }


    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(ModelMap model,
                         SessionStatus status) {

        status.setComplete();
        logger.info("quitte logout et retourne à l'index");
        logger.info(model);
        return "redirect:/index.jsp";
    }


    @RequestMapping(value = "/login/espaceMembre", method = RequestMethod.GET)
    public String goToMemberArea(ModelMap model,
                                 @SessionAttribute(value = "user") Member user,
                                 @ModelAttribute(value = "message") String message) {

        List<Guidebook> guidebooksForLoan = serviceGuidebook.getGuidebooksForLoan(user);
        serviceGuidebook.sortGuidebooks(guidebooksForLoan);

        model.put("guidebooksForLoan", guidebooksForLoan);
        model.put("message", message);
        return "espaceMembre";

    }

    @RequestMapping(value = "/login/resetPassword", method = RequestMethod.GET)
    public String displayResetPassword(ModelMap model) {
        model.put("action", "resetPassword");
        return "espaceMembre";
    }

    @RequestMapping(value = "/login/resetPassword", method = RequestMethod.POST)
    public String resetPassword(@RequestParam(value = "password1") String password1,
                                @RequestParam(value = "password2") String password2,
                                @SessionAttribute(value = "user") Member user,
                                ModelMap model) {

        if (password1.equals(password2)) {
            user.setPassword(password1);
            if (serviceLogin.updatePassword(user) == 1) {
                model.put("message", "ok");
            }
        } else {
            model.put("action", "resetPassword");
            model.put("message", "password2different");
        }
        return "espaceMembre";
    }


    @RequestMapping(value = "/newMember", method = RequestMethod.GET)
    public String displaysFormNewMember(@RequestParam(value = "afterLogin") String jspAfterLogin,
                                        ModelMap model) {
        model.put("jspAfterLogin", jspAfterLogin);
        return "newMember";
    }


    @RequestMapping(value = "/newMember", method = RequestMethod.POST)
    public String createNewMemberAccount(@RequestParam(value = "afterLogin") String jspAfterLogin,
                                         @RequestParam(value = "firstName") String firstName,
                                         @RequestParam(value = "surname") String surname,
                                         @RequestParam(value = "nickname") String nickname,
                                         @RequestParam(value = "email") String email,
                                         @RequestParam(value = "phone") String phone,
                                         @RequestParam(value = "password") String password,
                                         ModelMap model
    ) {

        if (serviceMember.isEmailAvailable(email) && serviceMember.isNicknameAvailable(nickname)) {
            Member newMemberWithoutKey = new Member();
            newMemberWithoutKey.setFirstName(firstLetterUpperCase(firstName));
            newMemberWithoutKey.setSurname(firstLetterUpperCase(surname));
            newMemberWithoutKey.setNickname(nickname);
            newMemberWithoutKey.setEmail(email);
            newMemberWithoutKey.setPhone(phone);
            newMemberWithoutKey.setPassword(password);

            serviceMember.insertNewMember(newMemberWithoutKey);
            model.put("jspAfterLogin", jspAfterLogin);
            model.put("newMemberAccount", "success");

            return "login";

        } else {
            model.put("afterLogin", jspAfterLogin);
            model.put("firstName", firstName);
            model.put("surname", surname);
            model.put("nickname", nickname);
            model.put("email", email);
            model.put("phone", phone);
            model.put("password", password);

            if (!serviceMember.isEmailAvailable(email)) {
                email = "";
                model.put("email", email);
            }
            if (!serviceMember.isNicknameAvailable(nickname)) {
                nickname = "";
                model.put("nickname", nickname);
            }

            model.put("jspAfterLogin", jspAfterLogin);
            return "newMember";
        }
    }


    @RequestMapping(value = "/admin/delete/memberAccount", method = RequestMethod.POST)
    public String deleteMemberAccount(@RequestParam(value = "userId") int userId,
                                      @RequestParam(value = "deleteMemberAccount", required = false) boolean checkboxValue,
                                      ModelMap model) {

        if (checkboxValue) {
            serviceMember.deleteMemberAccount(userId);
            model.put("message", "memberAccountDeleted");
            return ("redirect:/escalade/logout");
        } else {
            model.put("message", "checkboxNotChecked");
            return ("redirect:/escalade/login/espaceMembre");
        }
    }

}
