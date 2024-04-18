package webapp.helloworld.model;

import java.io.Serializable;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Matricula implements Serializable {
    @Id
    private int alunoID;
    @Id
    private int disciplinaID;

    public int getAlunoID() {
        return alunoID;
    }

    public void setAlunoID(int alunoID) {
        this.alunoID = alunoID;
    }

    public int getDisciplinaID() {
        return disciplinaID;
    }

    public void setDisciplinaID(int disciplinaID) {
        this.disciplinaID = disciplinaID;
    }
}
