package webapp.helloworld.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class IndexController {

    @GetMapping("/index")
    public String abrinIndex(Model model) {
        return "index";
    }

    @GetMapping("/login-adm")
    public String adminLogin(Model model) {
        return "login-adm";
    }

    @GetMapping("/cadastro-adm")
    public String adminCadastro(Model model) {
        return "cadastro-adm";
    }

    @PostMapping("/logout")
    public String postMethodName(@RequestBody String entity) {
        return entity;
    }

    @GetMapping("/dashboard-adm")
    public String showDashboard(Model model) {
        return "dashboard-adm";
    }

}
