package main.java.App;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

import main.java.View.JanelaElevadores;
import main.java.View.JanelaPrincipal;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class App {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Escolha a janela");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel panel = new JPanel();
        frame.add(panel);
        placeButtons(panel);

        frame.setVisible(true);
    }

    private static void placeButtons(JPanel panel) {
        panel.setLayout(null);

        JButton principalButton = new JButton("Janela Principal");
        principalButton.setBounds(50, 50, 200, 30);
        panel.add(principalButton);

        JButton elevadoresButton = new JButton("Janela de Elevadores");
        elevadoresButton.setBounds(50, 100, 200, 30);
        panel.add(elevadoresButton);

        principalButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new JanelaPrincipal().run();
            }
        });

        elevadoresButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new JanelaElevadores().run();
            }
        });
    }
}
