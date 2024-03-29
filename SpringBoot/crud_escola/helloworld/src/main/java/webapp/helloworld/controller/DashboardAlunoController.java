package webapp.helloworld.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import webapp.helloworld.model.Aluno;
import webapp.helloworld.repository.AlunoRepository;

import java.util.ArrayList;
import java.util.List;

@Controller
public class DashboardAlunoController {
    
    private static final Logger logger = LoggerFactory.getLogger(DashboardAlunoController.class);
    
    @Autowired
    private AlunoRepository alunoRepository;
    
    @GetMapping("/dashboard-aluno")
    public String dashboardAluno(Model model) {
        // Buscar todos os alunos cadastrados no banco de dados
        Iterable<Aluno> alunosIterable = alunoRepository.findAll();
        
        // Converter Iterable para List de forma segura
        List<Aluno> alunosList = new ArrayList<>();
        alunosIterable.forEach(alunosList::add);
        
        // Adicionar os alunos ao modelo para serem exibidos na página HTML
        model.addAttribute("alunos", alunosList);
        
        // Log para verificar se os alunos foram recuperados corretamente
        int numAlunos = alunosList.size();
        logger.info("Número de alunos recuperados do banco de dados: {}", numAlunos);
        
        return "dashboard-aluno"; // Nome da sua página HTML
    }
}
