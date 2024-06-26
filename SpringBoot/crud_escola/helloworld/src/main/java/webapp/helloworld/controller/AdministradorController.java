package webapp.helloworld.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import webapp.helloworld.model.Administrador;
import webapp.helloworld.model.VerificaCadastroAdm;
import webapp.helloworld.repository.AdministradorCadasto;
import webapp.helloworld.repository.VerificaCadastroAdmRepository;

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
        // Após o cadastro ser realizado com sucesso
        return "redirect:/login-adm?success=true";
    }

    // Método POST para processar o login do administrador
    @PostMapping("/login-adm")
public String processAdminLogin(@RequestParam("username") String username,
        @RequestParam("password") String password, HttpServletRequest request) {
    // Lógica para processar o login do administrador
    if (validarCredenciais(username, password)) {
        // As credenciais são válidas, cria uma nova sessão
        HttpSession session = request.getSession(true);

        // Define um atributo na sessão para indicar que o administrador está logado
        session.setAttribute("admin", true);

        // Redireciona para a página do painel administrativo
        return "redirect:/dashboard-adm";
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

    // Método para fazer logoff do administrador
    @GetMapping("/logoff-adm")
    public String logoffAdmin(HttpServletRequest request) {
        // Obtém a sessão atual, se existir
        HttpSession session = request.getSession(false);

        // Invalida a sessão, se existir
        if (session != null) {
            session.invalidate();
        }

        // Redireciona para a página inicial
        return "index";
    }
}