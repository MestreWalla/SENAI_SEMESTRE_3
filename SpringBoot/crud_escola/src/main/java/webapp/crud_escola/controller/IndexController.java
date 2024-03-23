package webapp.crud_escola.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {
    // Método
    @GetMapping("/index")
    public String abrinIndex(Model model) {
        return "index"; // Isso corresponde ao template "index.html" na pasta "templates"
    }
    @GetMapping("/login-adm")
    public String adminLogin(Model model) {
        return "login-adm";
    }
    @GetMapping("/cadastro-adm")
    public String adminCadastro(Model model) {
        return "cadastro-adm";
    }
}
