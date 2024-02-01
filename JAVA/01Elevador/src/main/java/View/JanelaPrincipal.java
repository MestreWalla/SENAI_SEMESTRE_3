package main.java.View;

import java.awt.Color;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import main.java.Controller.Controlador;

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

    // Arrays com os nomes dos botões
    private final String[] nomesBotoes = { "06", "05", "04", "03", "02", "01", "Terreo", "-01", "-02", "Sair" };
    private final String[] nomesBotoesChamar = { "Chamar 6", "Chamar 5", "Chamar 4", "Chamar 3", "Chamar 2", "Chamar 1", "Chamar Terreo", "Chamar -1", "Chamar -2" };
    private static final int NUM_LINHAS = 5;
    private static final int NUM_COLUNAS = 3;

    public JanelaPrincipal() {
        setLocationRelativeTo(null); // Centraliza a janela na tela
        AplicaNimbusLookAndFeel.pegaNimbus();

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(640, 480);

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
            botoesElevador2[i] = new JButton(nomesBotoes[i]);
            jPanelBotoes01.add(botoesElevador1[i]);
            jPanelBotoes02.add(botoesElevador2[i]);
        }

        for (String nomeBotao : nomesBotoesChamar) {
            JButton botoesChamar = new JButton(nomeBotao);
            jPanelBotoesChamar.add(botoesChamar);
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
public void atualizarInterface(int andarElevador1, int andarElevador2, boolean subindoElevador1, boolean subindoElevador2) {
    // Limpa o destaque visual dos botões
    limparDestaqueBotoes();

    // Destaca visualmente os botões correspondentes aos andares dos elevadores
    destaqueBotao(botoesElevador1, andarElevador1);
    destaqueBotao(botoesElevador2, andarElevador2);
    
    // Atualiza o texto do JLabel para exibir o status do Elevador01
    String statusElevador01 = "Andar atual: " + andarElevador1 + " | Status: ";
    statusElevador01 += subindoElevador1 ? "Subindo" : "Descendo";
    JLabel labelElevador01 = (JLabel) jPanelTexto01.getComponent(0);
    labelElevador01.setText(statusElevador01);
    
    // Atualiza o texto do JLabel para exibir o status do Elevador02
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

    // Método privado para destacar visualmente um botão específico
    private void destaqueBotao(JButton[] botoes, int andar) {
        if (andar >= -2 && andar <= 6) {
            // Calcula o índice do botão correspondente ao andar
            int indice = (andar >= 0) ? 6 - andar : Math.abs(andar) + 5;

            // Destaca visualmente o botão
            botoes[indice].setBackground(Color.GREEN);
        }
    }

    Botao01[4].addActionListener(e -> {
            
    });

    // Método para ação do botão do Elevador 1
    public static class BotaoElevador1Listener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            System.out.println("Botão do Elevador 1 clicado");
        }
    }

    public void run() {
        setVisible(true);
    }

    public static void main(String[] args) {
        JanelaPrincipal janela = new JanelaPrincipal();
        janela.run();
    }

    public static class AplicaNimbusLookAndFeel {

        private AplicaNimbusLookAndFeel() {
        }

        public static void pegaNimbus() {
            try {
                for (UIManager.LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
                    if ("Nimbus".equals(info.getName())) {
                        UIManager.setLookAndFeel(info.getClassName());
                        break;
                    }
                }
            } catch (UnsupportedLookAndFeelException | ClassNotFoundException | InstantiationException
                    | IllegalAccessException e) {
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
