package br.com.projeto.apirest_senai.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import br.com.projeto.apirest_senai.Repository.AmbienteRepository;
import br.com.projeto.apirest_senai.Repository.AtivoPatrimonialRepository;
import br.com.projeto.apirest_senai.Repository.ResponsavelRepository;

@Controller
public class HomeController {

    private final ResponsavelRepository responsavelRepository;
    private final AmbienteRepository ambienteRepository;
    private final AtivoPatrimonialRepository ativoPatrimonialRepository;

    public HomeController(ResponsavelRepository responsavelRepository,
            AmbienteRepository ambienteRepository,
            AtivoPatrimonialRepository ativoPatrimonialRepository) {
        this.responsavelRepository = responsavelRepository;
        this.ambienteRepository = ambienteRepository;
        this.ativoPatrimonialRepository = ativoPatrimonialRepository;
    }

    @GetMapping("/")
    public String index(Model model) {
        // Adicione os atributos necessários ao modelo
        model.addAttribute("responsaveis", responsavelRepository.findAll());
        model.addAttribute("ambientes", ambienteRepository.findAll());
        model.addAttribute("ativos", ativoPatrimonialRepository.findAll());
        // Retorna o nome da página HTML que será carregada
        return "index";
    }
}
