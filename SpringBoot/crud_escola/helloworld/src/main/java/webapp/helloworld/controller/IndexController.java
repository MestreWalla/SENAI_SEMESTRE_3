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

    @GetMapping("/login-aluno")
    public String alunoLogin(Model model) {
        return "login-aluno";
    }
    

    @GetMapping("/cadastro-adm")
    public String adminCadastro(Model model) {
        return "cadastro-adm";
    }

    @GetMapping("/cadastro-aluno")
    public String alunoCadastro(Model model) {
        return "cadastro-aluno";
    }
    
    @GetMapping("/cadastro-professor")
    public String professorCadastro(Model model) {
        return "cadastro-professor";
    }
    @PostMapping("/logout")
    public String postMethodName(@RequestBody String entity) {
        return entity;
    }
}
