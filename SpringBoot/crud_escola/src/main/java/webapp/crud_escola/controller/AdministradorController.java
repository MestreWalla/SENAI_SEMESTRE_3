package webapp.crud_escola.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

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

}
