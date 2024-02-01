package main.java.Model;

public class Elevador01 {
    private int andarAtual;
    private int velocidade;
    private boolean subindo; // Adiciona um atributo para controlar a direção do elevador

    public Elevador01(int andarAtual, int velocidade, int capacidade) {
        // Inicializa o elevador com os valores padrão
        this.andarAtual = andarAtual; // Inicia no térreo (andar 0)
        this.velocidade = 1000; // Define uma velocidade padrão (em milissegundos)
        this.subindo = false; // Inicia assumindo que o elevador está parado
    }

    // Método para obter o andar atual do elevador
    public int getAndarAtual() {
        return andarAtual;
    }

    // Método para definir o andar atual do elevador
    public void setAndarAtual(int andarAtual) {
        this.andarAtual = andarAtual;
    }

    // Método para obter a velocidade do elevador
    public int getVelocidade() {
        return velocidade;
    }

    // Método para definir a velocidade do elevador
    public void setVelocidade(int velocidade) {
        this.velocidade = velocidade;
    }

    // Método para verificar se o elevador está subindo
    public boolean isSubindo() {
        return subindo; // Retorna o valor da variável de controle de direção
    }

    // Método para definir se o elevador está subindo
    public void setSubindo(boolean subindo) {
        this.subindo = subindo;
    }
}
