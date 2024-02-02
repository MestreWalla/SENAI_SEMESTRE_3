package main.java.Controller;

import main.java.Model.Elevador01;
import main.java.Model.Elevador02;
import main.java.View.JanelaPrincipal;

public class Controlador {
    private Elevador01 elevador01;
    private Elevador02 elevador02;
    private JanelaPrincipal janelaPrincipal;

    public Controlador(Elevador01 elevador01, Elevador02 elevador02, JanelaPrincipal janelaPrincipal) {
        this.elevador01 = elevador01;
        this.elevador02 = elevador02;
        this.janelaPrincipal = janelaPrincipal;
    }

    // Método para chamar um elevador
    public void chamarElevador(int andar) {
        int distanciaElevador01 = Math.abs(elevador01.getAndarAtual() - andar);
        int distanciaElevador02 = Math.abs(elevador02.getAndarAtual() - andar);

        // Chama o elevador que estiver mais perto do andar solicitado
        if (distanciaElevador01 <= distanciaElevador02) {
            moverElevador(elevador01, andar);
        } else {
            moverElevador(elevador02, andar);
        }
    }

    // Método para mover um elevador para um determinado andar
    public void moverElevador(Elevador01 elevador, int andarDestino) {
        int andarAtual = elevador.getAndarAtual();
        int velocidade = elevador.getVelocidade();

        // Move o elevador para cima ou para baixo conforme necessário
        if (andarDestino > andarAtual) {
            while (andarAtual < andarDestino) {
                andarAtual++;
                elevador.setAndarAtual(andarAtual);
                atualizarInterface();
                esperar(velocidade); // Aguarda um tempo para simular o movimento
            }
        } else if (andarDestino < andarAtual) {
            while (andarAtual > andarDestino) {
                andarAtual--;
                elevador.setAndarAtual(andarAtual);
                atualizarInterface();
                esperar(velocidade); // Aguarda um tempo para simular o movimento
            }
        }

        // Quando o elevador chegar ao destino, atualiza a interface gráfica
        atualizarInterface();
    }

    // Método privado para atualizar a interface com os andares atuais dos elevadores
    private void atualizarInterface() {
        // Verifica se os elevadores estão subindo ou descendo
        boolean subindoElevador1 = elevador01.isSubindo();
        boolean subindoElevador2 = elevador02.isSubindo();

        // Passa os estados corretos dos elevadores para atualizar a interface
        janelaPrincipal.atualizarInterface(elevador01.getAndarAtual(), elevador02.getAndarAtual(), subindoElevador1, subindoElevador2);
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
