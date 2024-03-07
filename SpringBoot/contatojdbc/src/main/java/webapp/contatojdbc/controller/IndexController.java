package webapp.contatojdbc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import webapp.contatojdbc.connection.EmailDAO;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class IndexController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView abrirIndex() {
        ModelAndView mv = new ModelAndView("index");

        String mensagem = "Olá, seja bem-vinda(o)!";
        mv.addObject("msg", mensagem);
        new EmailDAO().criaTabela();
        return mv;
    }
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public ModelAndView buscarIndex(@RequestParam("email") String email) {
        ModelAndView mv = new ModelAndView("index");

        new EmailDAO().cadastrar(email);

        return mv;
    }
    
}
