package br.com.projeto.apirest_senai.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.projeto.apirest_senai.Model.AtivoPatrimonialModel;
import br.com.projeto.apirest_senai.Repository.AtivoPatrimonialRepository;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
@RequestMapping("/ativo")
public class AtivoController {
    
    @Autowired
    AtivoPatrimonialRepository repository;

    @GetMapping()
    public List<AtivoPatrimonialModel> getAtivo() {
        List<AtivoPatrimonialModel> Ativos = (List<AtivoPatrimonialModel>) repository.findAll();
        System.out.println(Ativos);
        return Ativos;
    }

    @PostMapping()
    public AtivoPatrimonialModel postAtivo(@RequestBody AtivoPatrimonialModel ativo) {
        AtivoPatrimonialModel salvo = repository.save(ativo);
        System.out.println(salvo);
        return salvo;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<AtivoPatrimonialModel>> getAtivoById(@PathVariable Long id) {
        Optional<AtivoPatrimonialModel> ativo = repository.findById(id);
        if (ativo.isPresent()) {
            System.out.println(ativo);
            return ResponseEntity.ok(ativo);
        } else {
            System.out.println("Responsável não encontrado");
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("{id}")
    public ResponseEntity<AtivoPatrimonialModel> putAtivo(@PathVariable Long id, @RequestBody AtivoPatrimonialModel ativo) {
        Optional<AtivoPatrimonialModel> busca = repository.findById(id);
        if (busca.isPresent()) {
            ativo.setId(id);
            AtivoPatrimonialModel atualizado = repository.save(ativo);
            System.out.println("Atualizado: " + atualizado);
            return ResponseEntity.ok(atualizado);
        } else {
            System.out.println("Responsável não encontrado para atualização");
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAtivo(@PathVariable Long id) {
        Optional<AtivoPatrimonialModel> busca = repository.findById(id);
        if (busca.isPresent()) {
            repository.deleteById(id);
            System.out.println("Deletado");
            return ResponseEntity.ok().build();
        } else {
            System.out.println("Responsável não encontrado para deleção");
            return ResponseEntity.notFound().build();
        }
    }
}
