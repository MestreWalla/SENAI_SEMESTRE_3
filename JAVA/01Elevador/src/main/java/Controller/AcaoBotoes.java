package main.java.Controller;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;

public class AcaoBotoes {

    private JButton[] botoesChamar;

    // Construtor que recebe o array de botões
    public AcaoBotoes(JButton[] botoesChamar) {
        this.botoesChamar = botoesChamar;
    }

    // Método para ação do botão do Elevador 1
    public class BotaoElevador1Listener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Adicione aqui a lógica para o botão do Elevador 1
            System.out.println("Botão do Elevador 1 clicado");
            // Exemplo de alteração da cor do botão
            botoesChamar[0].setBackground(Color.GREEN);
        }
    }

    // Método para ação do botão do Elevador 2
    public class BotaoElevador2Listener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Adicione aqui a lógica para o botão do Elevador 2
            System.out.println("Botão do Elevador 2 clicado");
        }
    }

    // Método para ação do botão de chamada de elevador
    public class BotaoChamarElevadorListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Adicione aqui a lógica para o botão de chamada de elevador
            System.out.println("Botão de chamada de elevador clicado");
        }
    }
}
