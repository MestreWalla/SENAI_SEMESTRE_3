package main.java.View;

import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

public class AplicaNimbusLookAndFeel {

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

