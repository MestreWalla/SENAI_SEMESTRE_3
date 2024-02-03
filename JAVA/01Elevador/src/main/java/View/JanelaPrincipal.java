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

public class JanelaPrincipal extends JFrame {

    Elevador01 elevador1 = new Elevador01();
    Elevador01 elevador2 = new Elevador01();

    // Declaração dos componentes da interface
    private JPanel jPanelBotoesChamar;
    private JPanel jPanelNada;
    private JPanel jPanelBotoes01;
    private JPanel jPanelBotoes02;
    private JPanel jPanelTexto01;
    private JPanel jPanelTexto02;
    private JButton[] botoesElevador1;
    private JButton[] botoesElevador2;
    // private static Controlador controlador;
    private Controlador controlador;

    // Arrays com os nomes dos botões
    private final String[] nomesBotoes = { "06", "05", "04", "03", "02", "01", "00", "-01", "-02", "Sair" };
    private final String[] nomesBotoesChamar = { "Chamar 6", "Chamar 5", "Chamar 4", "Chamar 3", "Chamar 2", "Chamar 1",
            "Chamar 0", "Chamar -1", "Chamar -2" };
    private static final int NumLinhas = 5;
    private static final int NumColunas = 3;

    public JanelaPrincipal() {
        setLocationRelativeTo(null); // Centraliza a janela na tela
        AplicaNimbusLookAndFeel.pegaNimbus();
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(640, 480);
        criarComponentes();
        configurarLayout();
        atualizarInterface(elevador1.getAndarAtual(), elevador2.getAndarAtual(), elevador1.isSubindo(),
                elevador1.isSubindo());
    }

    private void criarComponentes() {
        jPanelBotoesChamar = new JPanel(new GridLayout(9, 1));
        jPanelBotoes01 = new JPanel(new GridLayout(NumLinhas, NumColunas));
        jPanelBotoes02 = new JPanel(new GridLayout(NumLinhas, NumColunas));
        jPanelTexto01 = new JPanel(); // Inicializa o painel de texto 01
        jPanelTexto02 = new JPanel(); // Inicializa o painel de texto 02
    
        // Adiciona o JLabel para exibir o status do Elevador01
        JLabel labelElevador1 = new JLabel("Andar atual: 0 | Status: Parado");
        jPanelTexto01.add(labelElevador1);
    
        // Adiciona o JLabel para exibir o status do Elevador02
        JLabel labelElevador2 = new JLabel("Andar atual: 0 | Status: Parado");
        jPanelTexto02.add(labelElevador2);
    
        // Define a cor de fundo dos painéis de texto
        jPanelTexto01.setBackground(Color.LIGHT_GRAY);
        jPanelTexto02.setBackground(Color.LIGHT_GRAY);
    
        jPanelNada = new JPanel(); // Inicializa o painel espaço vazio
    
        botoesElevador1 = new JButton[nomesBotoes.length];
        botoesElevador2 = new JButton[nomesBotoes.length];
    
        for (int i = 0; i < nomesBotoes.length; i++) {
            botoesElevador1[i] = new JButton(nomesBotoes[i]);
            botoesElevador1[i].addActionListener(new BotaoElevador1Listener());
            jPanelBotoes01.add(botoesElevador1[i]);
    
            botoesElevador2[i] = new JButton(nomesBotoes[i]);
            botoesElevador2[i].addActionListener(new BotaoElevador2Listener());
            jPanelBotoes02.add(botoesElevador2[i]);
        }
    
        for (String nomeBotao : nomesBotoesChamar) {
            JButton botaoChamar = new JButton(nomeBotao);
            botaoChamar.addActionListener(new BotaoChamarListener(nomeBotao));
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
        JLabel labelElevador1 = (JLabel) jPanelTexto01.getComponent(0);
        labelElevador1.setText(statusElevador01);

        String statusElevador02 = "Andar atual: " + andarElevador2 + " | Status: ";
        statusElevador02 += subindoElevador2 ? "Subindo" : "Descendo";
        JLabel labelElevador2 = (JLabel) jPanelTexto02.getComponent(0);
        labelElevador2.setText(statusElevador02);
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

    // método para abrir o frame
    public void run() {
        Controlador controlador = new Controlador(elevador1, elevador2, this);
        setControlador(controlador);
        setVisible(true);
    }

    public void setControlador(Controlador controlador) {
        this.controlador = controlador;
    }

    private class BotaoElevador1Listener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            JButton botaoClicado = (JButton) e.getSource();
            String textoBotao = botaoClicado.getText();
            System.out.println("Botão do Elevador 1 clicado: " + textoBotao);

            // Cor dos botões
            limparDestaqueBotoes(); // Corrija para limparDestaqueBotoes()

            botaoClicado.setBackground(Color.GREEN);

            // Recuperar andar selecionadoe converter para Int
            String numeroAndar = textoBotao.replaceAll("\\D+", "");
            int andarDestino = Integer.parseInt(numeroAndar);

            controlador.moverElevador(elevador1, andarDestino);

        }
    }

    private class BotaoElevador2Listener implements ActionListener {

        @Override
        public void actionPerformed(ActionEvent e) {
            JButton botaoClicado = (JButton) e.getSource();
            String textoBotao = botaoClicado.getText();
            System.out.println("Botão do Elevador 2 clicado: " + textoBotao);

            // Cor dos botões
            limparDestaqueBotoes(); // Corrija para limparDestaqueBotoes()

            botaoClicado.setBackground(Color.GREEN);

            // Recuperar andar selecionadoe converter para Int
            String numeroAndar = textoBotao.replaceAll("\\D+", "");
            int andarDestino = Integer.parseInt(numeroAndar);

            controlador.moverElevador(elevador2, andarDestino);
        }
    }

    private class BotaoChamarListener implements ActionListener {
        private final String nomeBotao;

        public BotaoChamarListener(String nomeBotao) {
            this.nomeBotao = nomeBotao;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            JButton botaoClicado = (JButton) e.getSource();
            String textoBotao = botaoClicado.getText();
            System.out.println("Botão de chamada clicado: " + textoBotao);
            setControlador(controlador);
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
