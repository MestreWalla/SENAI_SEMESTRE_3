package webapp.helloworld.model;

import java.io.Serializable;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Turma implements Serializable {
    @Id
    private int id;
    private int disciplinaID;
    private int professorID;
    private int ano;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getDisciplinaID() {
        return disciplinaID;
    }
    public void setDisciplinaID(int disciplinaID) {
        this.disciplinaID = disciplinaID;
    }
    public int getProfessorID() {
        return professorID;
    }
    public void setProfessorID(int professorID) {
        this.professorID = professorID;
    }
    public int getAno() {
        return ano;
    }
    public void setAno(int ano) {
        this.ano = ano;
    }
}
