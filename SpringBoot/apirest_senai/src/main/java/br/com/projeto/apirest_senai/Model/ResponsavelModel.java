package br.com.projeto.apirest_senai.Model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Setter
@Getter
public class ResponsavelModel implements Serializable {
    @Id
    private Long id;
    private String nome;
}
