package webapp.helloworld.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import webapp.helloworld.model.Aluno;
import webapp.helloworld.repository.AlunoRepository;

@Controller
public class CadastroAlunoController {
    @Autowired
    private AlunoRepository ar;
    @PostMapping("/cadastro-aluno")
    public String postCadastroAluno(Aluno aluno) {
        ar.save(aluno);
        // Após o cadastro ser realizado com sucesso
        return "redirect:/login-adm?success=true";
    }

    // Método POST para processar o login do aluno
    @PostMapping("/login-aluno")
    public String processAdminLogin(@RequestParam("username") String username,
            @RequestParam("password") String password) {
        // Lógica para processar o login do aluno
        if (validarCredenciais(username, password)) {
            // As credenciais são válidas, redireciona para a página do painel
            // administrativo
            return "/dashboard-adm";
        } else {
            // As credenciais são inválidas, redireciona de volta para a página de login com
            // uma mensagem de erro
            return "redirect:/login-adm?error";
        }
    }

    // Método privado para validar as credenciais do aluno
    private boolean validarCredenciais(String username, String password) {
        // Consultar o banco de dados para verificar se existe um aluno com o
        // nome de usuário fornecido
        Aluno aluno = ar.findByUsername(username);
        // Verificar se o aluno foi encontrado e se a senha fornecida
        // corresponde à senha armazenada
        if (aluno != null && aluno.getSenha().equals(password)) {
            return true; // Credenciais válidas
        } else {
            return false; // Credenciais inválidas
        }
    }

}
