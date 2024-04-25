package webapp.helloworld.controller;

import java.util.List;
import java.util.concurrent.atomic.AtomicLong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import webapp.helloworld.model.Disciplina;
import webapp.helloworld.repository.DisciplinaRepository;

@Controller
public class CadastroDisciplinaController {

    @Autowired
    private DisciplinaRepository disciplinaRepository;

    // Usado para gerar IDs únicos para as disciplinas
    private AtomicLong idGenerator = new AtomicLong();

    @PostMapping("/salvar-disciplina")
    public String postCadastroDisciplina(Disciplina disciplina) {
        // Se o ID da disciplina não foi definido, gerar um novo ID único
        if (disciplina.getId() == 0) {
            disciplina.setId((int) idGenerator.incrementAndGet());
        }

        // Salvar a disciplina no banco de dados
        disciplinaRepository.save(disciplina);

        // Após o cadastro ser realizado com sucesso, redirecionar para a página de sucesso
        return "redirect:/cadastro-disciplina?success=true";
    }

    @GetMapping("/disciplina-dash")
    public String getDisciplinaDashboard(Model model) {
        // Recuperar as disciplinas do banco de dados
        List<Disciplina> disciplinas = disciplinaRepository.findAll();

        // Passar as disciplinas para a visualização
        model.addAttribute("disciplinas", disciplinas);

        // Retornar o nome da página Thymeleaf que irá renderizar o dashboard de disciplinas
        return "disciplina-dash";
    }

    @GetMapping("/cadastro-disciplina")
    public String getMethodDisciplina(Model model) {
        // Adicione aqui a lógica necessária para preparar os dados que serão exibidos na página
        return "cadastro-disciplina"; // Retorne o nome da página Thymeleaf
    }
}
