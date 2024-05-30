package br.com.projeto.apirest_senai.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.projeto.apirest_senai.Model.ResponsavelModel;
import br.com.projeto.apirest_senai.Repository.ResponsavelRepository;

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
@RequestMapping("/responsavel")
public class ResponsavelController {
    
    @Autowired
    ResponsavelRepository repository;

    @GetMapping()
    public List<ResponsavelModel> getResponsavel() {
        List<ResponsavelModel> responsaveis = (List<ResponsavelModel>) repository.findAll();
        System.out.println(responsaveis);
        return responsaveis;
    }

    @PostMapping()
    public ResponsavelModel postResponsavel(@RequestBody ResponsavelModel responsavel) {
        ResponsavelModel salvo = repository.save(responsavel);
        System.out.println(salvo);
        return salvo;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<ResponsavelModel>> getResponsavelById(@PathVariable Long id) {
        Optional<ResponsavelModel> responsavel = repository.findById(id);
        if (responsavel.isPresent()) {
            System.out.println(responsavel);
            return ResponseEntity.ok(responsavel);
        } else {
            System.out.println("Responsável não encontrado");
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("{id}")
    public ResponseEntity<ResponsavelModel> putResponsavel(@PathVariable Long id, @RequestBody ResponsavelModel responsavel) {
        Optional<ResponsavelModel> busca = repository.findById(id);
        if (busca.isPresent()) {
            responsavel.setId(id);
            ResponsavelModel atualizado = repository.save(responsavel);
            System.out.println("Atualizado: " + atualizado);
            return ResponseEntity.ok(atualizado);
        } else {
            System.out.println("Responsável não encontrado para atualização");
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteResponsavel(@PathVariable Long id) {
        Optional<ResponsavelModel> busca = repository.findById(id);
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
