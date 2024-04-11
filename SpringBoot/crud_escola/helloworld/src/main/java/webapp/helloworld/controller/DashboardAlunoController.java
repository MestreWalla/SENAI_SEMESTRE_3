package webapp.helloworld.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import webapp.helloworld.model.Aluno;
import webapp.helloworld.repository.AlunoRepository;

import java.util.ArrayList;
import java.util.List;

@Controller
public class DashboardAlunoController {

    private static final Logger logger = LoggerFactory.getLogger(DashboardAlunoController.class);

    @Autowired
    private AlunoRepository alunoRepository;

    // Mantendo o mapeamento para /dashboard-aluno neste controlador
    @GetMapping("/alunos-dash")
    public String dashboardAluno(Model model) {
        Iterable<Aluno> alunosIterable = alunoRepository.findAll();

        List<Aluno> alunosList = new ArrayList<>();
        alunosIterable.forEach(alunosList::add);

        model.addAttribute("alunos", alunosList);

        int numAlunos = alunosList.size();
        System.out.println(String.format("Número de alunos recuperados do banco de dados: %d", numAlunos));
        logger.info("Número de alunos recuperados do banco de dados: {}", numAlunos);

        for (Aluno aluno : alunosList) {
            logger.info("Nome do aluno: {}", aluno.getUsername());
        }

        return "alunos-dash";
    }

    @GetMapping("/editar-aluno/{cpf}")
    public String editarAluno(@PathVariable String cpf, Model model) {
        // Buscar o aluno com o CPF especificado no banco de dados
        Aluno aluno = alunoRepository.findByCpf(cpf);

        // Verificar se o aluno foi encontrado
        if (aluno != null) {
            // Adicionar o aluno ao modelo para ser exibido na página de edição
            model.addAttribute("aluno", aluno);

            // Retornar o nome da página de edição
            return "editar-aluno"; // Substitua por sua página de edição
        } else {
            // Se o aluno não for encontrado, redirecionar de volta para o dashboard com uma
            // mensagem de erro
            return "redirect:/alunos-dash?error=Aluno não encontrado";
        }
    }

    public class EdicaoAlunoController {

        @Autowired
        private AlunoRepository alunoRepository;

        @PostMapping("/salvar-edicao-aluno")
        public String salvarEdicaoAluno(Aluno aluno) {
            // Verificar se o aluno existe no banco de dados
            Aluno alunoExistente = alunoRepository.findByCpf(aluno.getCpf());
            if (alunoExistente != null) {
                // Atualizar as informações do aluno existente com base nos dados enviados do
                // formulário de edição
                alunoExistente.setUsername(aluno.getUsername());
                alunoExistente.setEmail(aluno.getEmail());
                alunoExistente.setMateria01(aluno.getMateria01());
                alunoExistente.setMateria02(aluno.getMateria02());
                alunoExistente.setProfessor01(aluno.getProfessor01());
                alunoExistente.setProfessor02(aluno.getProfessor02());

                // Salvar as alterações no banco de dados
                alunoRepository.save(alunoExistente);

                // Redirecionar de volta para o dashboard com uma mensagem de sucesso
                return "redirect:/alunos-dash?success=Aluno editado com sucesso";
            } else {
                // Se o aluno não existir, redirecionar de volta para o dashboard com uma
                // mensagem de erro
                return "redirect:/alunos-dash?error=Aluno não encontrado";
            }
        }
    }

    @GetMapping("/excluir-aluno/{cpf}")
    public String excluirAluno(@PathVariable String cpf) {
        // Buscar o aluno com o CPF especificado no banco de dados
        Aluno aluno = alunoRepository.findByCpf(cpf);

        // Verificar se o aluno foi encontrado
        if (aluno != null) {
            // Excluir o aluno do banco de dados
            alunoRepository.delete(aluno);

            // Redirecionar de volta para o dashboard com uma mensagem de sucesso
            return "redirect:/alunos-dash?success=Aluno excluído com sucesso";
        } else {
            // Se o aluno não for encontrado, redirecionar de volta para o dashboard com uma
            // mensagem de erro
            return "redirect:/alunos-dash?error=Aluno não encontrado";
        }
    }

}
