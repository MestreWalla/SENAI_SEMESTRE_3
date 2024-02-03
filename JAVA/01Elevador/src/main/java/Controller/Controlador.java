package main.java.Controller;

import main.java.Model.Elevador01;
import main.java.View.JanelaPrincipal;

public class Controlador {
    private Elevador01 elevador1;
    private Elevador01 elevador2;
    private JanelaPrincipal janelaPrincipal;

    public Controlador(Elevador01 elevador1, Elevador01 elevador2, JanelaPrincipal janelaPrincipal) {
        this.elevador1 = elevador1;
        this.elevador2 = elevador2;
        this.janelaPrincipal = janelaPrincipal;
    }

    // Método para chamar um elevador
    public void chamarElevador(int andarDesejado) {
        int distanciaElevador1 = Math.abs(elevador1.getAndarAtual() - andarDesejado);
        int distanciaElevador2 = Math.abs(elevador2.getAndarAtual() - andarDesejado);

        // Chama o elevador que estiver mais perto do andar solicitado
        if (distanciaElevador1 <= distanciaElevador2) {
            moverElevador(elevador1, andarDesejado);
        } else {
            moverElevador(elevador2, andarDesejado);
        }
    }

    // Método para mover um elevador para um determinado andar
    public void moverElevador(Elevador01 elevador, int andarDestino) {
        int andarAtual = elevador.getAndarAtual();
        int velocidade = elevador.getVelocidade();

        // Move o elevador para cima ou para baixo conforme necessário
        if (andarDestino > andarAtual) {
            while (andarAtual < andarDestino) {
                elevador.setSubindo(true);
                andarAtual++;
                elevador.setAndarAtual(andarAtual);
                atualizarInterface();
                esperar(velocidade); // Aguarda um tempo para simular o movimento
            }
        } else if (andarDestino < andarAtual) {
            while (andarAtual > andarDestino) {
                elevador.setSubindo(false);
                andarAtual--;
                elevador.setAndarAtual(andarAtual);
                atualizarInterface();
                esperar(velocidade); // Aguarda um tempo para simular o movimento
            }
        }

        // Quando o elevador chegar ao destino, atualiza a interface gráfica
        atualizarInterface();
    }

    // Método privado para atualizar a interface com os andares atuais dos
    // elevadores
    private void atualizarInterface() {
        // Verifica se os elevadores estão subindo ou descendo
        boolean subindoElevador1 = elevador1.isSubindo();
        boolean subindoElevador2 = elevador2.isSubindo();

        // Passa os estados corretos dos elevadores para atualizar a interface
        janelaPrincipal.atualizarInterface(elevador1.getAndarAtual(), elevador2.getAndarAtual(), subindoElevador1,
                subindoElevador2);
    }

    // Método privado para simular um tempo de espera
    private void esperar(int milissegundos) {
        try {
            Thread.sleep(milissegundos);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
