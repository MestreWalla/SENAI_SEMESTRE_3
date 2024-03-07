package webapp.contatojdbc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import webapp.contatojdbc.connection.EmailDAO;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class IndexController {

    @Autowired
    private EmailDAO emailDAO; // Injeção do EmailDAO

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView abrirIndex() {
        ModelAndView mv = new ModelAndView("index");

        String mensagem = "Olá, seja bem-vindo(a)!";
        mv.addObject("msg", mensagem);

        List<String> emails = emailDAO.buscarEmails(); // Método para buscar os emails
        mv.addObject("emails", emails);

        return mv;
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public ModelAndView buscarIndex(@RequestParam("email") String email) {
        ModelAndView mv = new ModelAndView("index");

        emailDAO.cadastrar(email); // Chamada do método para cadastrar o email

        return mv;
    }
}
