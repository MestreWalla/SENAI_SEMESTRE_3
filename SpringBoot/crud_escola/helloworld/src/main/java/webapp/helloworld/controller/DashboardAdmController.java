package webapp.helloworld.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import webapp.helloworld.model.Aluno;
import webapp.helloworld.model.Professor;
import webapp.helloworld.model.Disciplina; // Importar a classe Disciplina
import webapp.helloworld.repository.AlunoRepository;
import webapp.helloworld.repository.ProfessorRepository;
import webapp.helloworld.repository.DisciplinaRepository; // Importar o repositório de disciplinas

@Controller
public class DashboardAdmController {

    @Autowired
    private AlunoRepository alunoRepository;

    @Autowired
    private ProfessorRepository professorRepository;

    @Autowired
    private DisciplinaRepository disciplinaRepository; // Injetar o repositório de disciplinas

    @GetMapping("/dashboard-adm")
    public String showDashboard(Model model, HttpServletRequest request) {
        // Verifica se há uma sessão de administrador ativa
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            // Se não houver sessão ativa, redireciona para a página de login do administrador
            return "redirect:/login-adm";
        }
        
        // Obter os alunos do banco de dados
        Iterable<Aluno> alunosIterable = alunoRepository.findAll();
        List<Aluno> alunosList = new ArrayList<>();
        alunosIterable.forEach(alunosList::add);

        // Obter os professores do banco de dados
        Iterable<Professor> professoresIterable = professorRepository.findAll();
        List<Professor> professoresList = new ArrayList<>();
        professoresIterable.forEach(professoresList::add);

        // Obter as disciplinas do banco de dados
        Iterable<Disciplina> disciplinasIterable = disciplinaRepository.findAll();
        List<Disciplina> disciplinasList = new ArrayList<>();
        disciplinasIterable.forEach(disciplinasList::add);

        // Adicionar alunos, professores e disciplinas ao modelo
        model.addAttribute("alunos", alunosList);
        model.addAttribute("professores", professoresList);
        model.addAttribute("disciplinas", disciplinasList);

        // Se houver uma sessão ativa, exibe a página de dashboard
        return "/dashboard-adm";
    }
}
