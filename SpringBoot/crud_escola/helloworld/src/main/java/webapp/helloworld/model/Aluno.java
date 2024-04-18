package webapp.helloworld.model;

import java.io.Serializable;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;

@Entity
public class Aluno implements Serializable {
    //Atriburos (Colunas da tabela)
    @Id
    private String cpf;
    private String username;
    private String email;
    private String senha;
    private String materia01;
    private String materia02;
    private String professor01;
    private String professor02;
    @JoinColumn(name="disciplina_id", referencedColumnName = "id")
    private Disciplina disciplina;
    
    public String getCpf() {
        return cpf;
    }
    public String getMateria01() {
        return materia01;
    }
    public void setMateria01(String materia01) {
        this.materia01 = materia01;
    }
    public String getMateria02() {
        return materia02;
    }
    public void setMateria02(String materia02) {
        this.materia02 = materia02;
    }
    public String getProfessor01() {
        return professor01;
    }
    public void setProfessor01(String professor01) {
        this.professor01 = professor01;
    }
    public String getProfessor02() {
        return professor02;
    }
    public void setProfessor02(String professor02) {
        this.professor02 = professor02;
    }
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getSenha() {
        return senha;
    }
    public void setSenha(String senha) {
        this.senha = senha;
    }
    
}
