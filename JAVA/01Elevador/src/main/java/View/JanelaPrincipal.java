package main.java.View;

import java.awt.Color;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

import main.java.Controller.Controlador;
import main.java.Model.Elevador01;
import main.java.Model.Elevador02;

public class JanelaPrincipal extends JFrame {

    // Declaração dos componentes da interface
    private JPanel jPanelBotoesChamar;
    private JPanel jPanelNada;
    private JPanel jPanelBotoes01;
    private JPanel jPanelBotoes02;
    private JPanel jPanelTexto01;
    private JPanel jPanelTexto02;
    private JButton[] botoesElevador1;
    private JButton[] botoesElevador2;
    private static Controlador controlador;
    private Elevador01 elevador01; // Adicionando uma referência ao elevador 01

    // Arrays com os nomes dos botões
    private final String[] nomesBotoes = { "06", "05", "04", "03", "02", "01", "00", "-01", "-02", "Sair" };
    private final String[] nomesBotoesChamar = { "Chamar 6", "Chamar 5", "Chamar 4", "Chamar 3", "Chamar 2", "Chamar 1",
            "Chamar 0", "Chamar -1", "Chamar -2" };
    private static final int NUM_LINHAS = 5;
    private static final int NUM_COLUNAS = 3;

    public JanelaPrincipal(Controlador controlador) {
        setLocationRelativeTo(null); // Centraliza a janela na tela
        AplicaNimbusLookAndFeel.pegaNimbus();

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(640, 480);

        // Inicialize o elevador 01
        this.elevador01 = new Elevador01(0, 1000, 10);

        criarComponentes();
        configurarLayout();
        atualizarInterface(0, 0, false, false);
    }

    private void criarComponentes() {
        jPanelBotoesChamar = new JPanel(new GridLayout(9, 1));
        jPanelBotoes01 = new JPanel(new GridLayout(NUM_LINHAS, NUM_COLUNAS));
        jPanelBotoes02 = new JPanel(new GridLayout(NUM_LINHAS, NUM_COLUNAS));
        jPanelTexto01 = new JPanel(); // Inicializa o painel de texto 01
        jPanelTexto02 = new JPanel(); // Inicializa o painel de texto 02

        // Adiciona o JLabel para exibir o status do Elevador01
        JLabel labelElevador01 = new JLabel("Andar atual: 0 | Status: Parado");
        jPanelTexto01.add(labelElevador01);

        // Adiciona o JLabel para exibir o status do Elevador02
        JLabel labelElevador02 = new JLabel("Andar atual: 0 | Status: Parado");
        jPanelTexto02.add(labelElevador02);

        // Define a cor de fundo dos painéis de texto
        jPanelTexto01.setBackground(Color.LIGHT_GRAY);
        jPanelTexto02.setBackground(Color.LIGHT_GRAY);

        jPanelNada = new JPanel(); // Inicializa o painel nada

        botoesElevador1 = new JButton[nomesBotoes.length];
        botoesElevador2 = new JButton[nomesBotoes.length];

        for (int i = 0; i < nomesBotoes.length; i++) {
            botoesElevador1[i] = new JButton(nomesBotoes[i]);
            botoesElevador1[i].addActionListener(new BotaoElevador1Listener(controlador, elevador01)); // Passando a referência do elevador 01
            jPanelBotoes01.add(botoesElevador1[i]);
            botoesElevador2[i] = new JButton(nomesBotoes[i]);
            jPanelBotoes02.add(botoesElevador2[i]);
        }

        for (String nomeBotao : nomesBotoesChamar) {
            JButton botaoChamar = new JButton(nomeBotao);
            botaoChamar.addActionListener(new BotaoChamarListener(nomeBotao, controlador));
            jPanelBotoesChamar.add(botaoChamar);
        }

    }

    private void configurarLayout() {
        // Define o layout como GridLayout com 2 linha e 3 colunas
        setLayout(new GridLayout(2, 3));

        // Adiciona os painéis de botões e texto ao painel principal
        add(jPanelNada);
        add(jPanelTexto01);
        add(jPanelTexto02);

        add(jPanelBotoesChamar);
        add(jPanelBotoes01);
        add(jPanelBotoes02);
    }

    // Método para atualizar a interface com os andares atuais dos elevadores
    public void atualizarInterface(int andarElevador1, int andarElevador2, boolean subindoElevador1,
            boolean subindoElevador2) {
        limparDestaqueBotoes();

        destaqueBotao(botoesElevador1, andarElevador1);
        destaqueBotao(botoesElevador2, andarElevador2);

        String statusElevador01 = "Andar atual: " + andarElevador1 + " | Status: ";
        statusElevador01 += subindoElevador1 ? "Subindo" : "Descendo";
        JLabel labelElevador01 = (JLabel) jPanelTexto01.getComponent(0);
        labelElevador01.setText(statusElevador01);

        String statusElevador02 = "Andar atual: " + andarElevador2 + " | Status: ";
        statusElevador02 += subindoElevador2 ? "Subindo" : "Descendo";
        JLabel labelElevador02 = (JLabel) jPanelTexto02.getComponent(0);
        labelElevador02.setText(statusElevador02);
    }

    private void limparDestaqueBotoes() {
        for (JButton botao : botoesElevador1) {
            botao.setBackground(null);
        }
        for (JButton botao : botoesElevador2) {
            botao.setBackground(null);
        }
    }

    private void destaqueBotao(JButton[] botoes, int andar) {
        if (andar >= -2 && andar <= 6) {
            int indice = (andar >= 0) ? 6 - andar : Math.abs(andar) + 5;
            botoes[indice].setBackground(Color.GREEN);
        }
    }

    public void run() {
        this.setVisible(true);
    }

    public static void main(String[] args) {
        Elevador01 elevador01 = new Elevador01(0, 1000, 10); // Inicialize o Elevador01
        Elevador02 elevador02 = new Elevador02(0, 1000, 10); // Inicialize o Elevador02
        Controlador controlador = new Controlador(elevador01, elevador02, null); // Crie uma instância de Controlador
        JanelaPrincipal janela = new JanelaPrincipal(controlador); // Inicialize a JanelaPrincipal com o Controlador
        janela.run(); // Execute a janela principal
    }

    private class BotaoElevador1Listener implements ActionListener {
        private final Controlador controlador;
        private final Elevador01 elevador;

        public BotaoElevador1Listener(Controlador controlador, Elevador01 elevador) {
            this.controlador = controlador;
            this.elevador = elevador;
        }

        public void actionPerformed(ActionEvent e) {
            JButton botaoClicado = (JButton) e.getSource();
            String textoBotao = botaoClicado.getText();
            System.out.println("Botão do Elevador 1 clicado: " + textoBotao);

            // Cor dos botoes
            limparCoresBotoes();
            botaoClicado.setBackground(Color.GREEN);

            // Recuperar andar selecionadoe converter para Int
            String numeroAndar = textoBotao.replaceAll("\\D+", "");
            int andarDestino = Integer.parseInt(numeroAndar);


                controlador.moverElevador(elevador, andarDestino);
         
        }

        private void limparCoresBotoes() {
            for (JButton botao : botoesElevador1) {
                botao.setBackground(null);
            }
            for (JButton botao : botoesElevador2) {
                botao.setBackground(null);
            }
        }

    }

    private class BotaoChamarListener implements ActionListener {
        private final String nomeBotao;
        private final Controlador controlador;

        public BotaoChamarListener(String nomeBotao, Controlador controlador) {
            this.nomeBotao = nomeBotao;
            this.controlador = controlador;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            JButton botaoClicado = (JButton) e.getSource();
            String textoBotao = botaoClicado.getText();
            System.out.println("Botão de chamada clicado: " + textoBotao);

            String numero = nomeBotao.replaceAll("\\D+", "");
            int andarDesejado = Integer.parseInt(numero);

            if (controlador != null) {
                controlador.chamarElevador(andarDesejado);
            } else {
                System.err.println("Controlador não inicializado.");
            }
        }
    }
}
