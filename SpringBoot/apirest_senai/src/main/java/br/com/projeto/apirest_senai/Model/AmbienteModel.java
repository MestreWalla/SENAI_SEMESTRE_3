package br.com.projeto.apirest_senai.Model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Entity
@Setter
@Getter
public class AmbienteModel implements Serializable{
    @Id
    private Long id;
    private String nome;
    @ManyToOne
    @JoinColumn(name = "id_responsavel")
    private ResponsavelModel responsavel;
}
