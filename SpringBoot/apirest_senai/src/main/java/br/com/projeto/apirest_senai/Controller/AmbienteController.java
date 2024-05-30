package br.com.projeto.apirest_senai.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.projeto.apirest_senai.Model.AmbienteModel;
import br.com.projeto.apirest_senai.Repository.AmbienteRepository;
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
@RequestMapping("/ambiente")
public class AmbienteController {
    
    @Autowired
    AmbienteRepository repository;

    @GetMapping()
    public List<AmbienteModel> getAmbiente() {
        List<AmbienteModel> ambientes = (List<AmbienteModel>) repository.findAll();
        System.out.println(ambientes);
        return ambientes;
    }

    @PostMapping()
    public AmbienteModel postAmbiente(@RequestBody AmbienteModel ambiente) {
        AmbienteModel salvo = repository.save(ambiente);
        System.out.println(salvo);
        return salvo;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<AmbienteModel>> getAmbienteById(@PathVariable Long id) {
        Optional<AmbienteModel> ambiente = repository.findById(id);
        if (ambiente.isPresent()) {
            System.out.println(ambiente);
            return ResponseEntity.ok(ambiente);
        } else {
            System.out.println("Responsável não encontrado");
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("{id}")
    public ResponseEntity<AmbienteModel> putAmbiente(@PathVariable Long id, @RequestBody AmbienteModel ambiente) {
        Optional<AmbienteModel> busca = repository.findById(id);
        if (busca.isPresent()) {
            ambiente.setId(id);
            AmbienteModel atualizado = repository.save(ambiente);
            System.out.println("Atualizado: " + atualizado);
            return ResponseEntity.ok(atualizado);
        } else {
            System.out.println("Responsável não encontrado para atualização");
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAmbiente(@PathVariable Long id) {
        Optional<AmbienteModel> busca = repository.findById(id);
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
