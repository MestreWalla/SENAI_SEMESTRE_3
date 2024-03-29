package webapp.crud_escola.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import webapp.crud_escola.model.Administrador;
import webapp.crud_escola.model.VerificaCadastroAdm;
import webapp.crud_escola.repository.AdministradorCadasto;
import webapp.crud_escola.repository.VerificaCadastroAdmRepository;

@Controller
public class AdministradorController {
    @Autowired
    private AdministradorCadasto ar;
    @Autowired
    private VerificaCadastroAdmRepository vcar;

    @PostMapping("/cadastro-adm")
    public String postCadastroADM(Administrador adm) {
        VerificaCadastroAdm verificaCadastroAdm = vcar.findByCpf(adm.getCpf());
        if (verificaCadastroAdm != null && verificaCadastroAdm.getCpf().equals(adm.getCpf())) {
            ar.save(adm);
        }
        return "/login-adm";
    }

    // Método POST para processar o login do administrador
    @PostMapping("/login-adm")
    public String processAdminLogin(@RequestParam("username") String username,
            @RequestParam("password") String password) {
        // Lógica para processar o login do administrador
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

    // Método privado para validar as credenciais do administrador
    private boolean validarCredenciais(String username, String password) {
        // Consultar o banco de dados para verificar se existe um administrador com o
        // nome de usuário fornecido
        Administrador administrador = ar.findByUsername(username);

        // Verificar se o administrador foi encontrado e se a senha fornecida
        // corresponde à senha armazenada
        if (administrador != null && administrador.getSenha().equals(password)) {
            return true; // Credenciais válidas
        } else {
            return false; // Credenciais inválidas
        }
    }

}
