import java.awt.*;
import javax.swing.*;

public class Announcements {
    public void showWindow() {
        JFrame frame = new JFrame("Barangay San Marino - Announcements");
        frame.setSize(600, 400);
        frame.setLayout(new BorderLayout());

        JPanel header = new JPanel();
        header.setBackground(new Color(241, 196, 15)); // Yellow/Gold color
        JLabel title = new JLabel("BARANGAY ANNOUNCEMENTS");
        title.setFont(new Font("Segoe UI", Font.BOLD, 18));
        header.add(title);

        JTextArea txtNews = new JTextArea("1. Libreng Bakuna bukas sa Covered Court.\n2. Barangay Assembly sa Sabado.");
        txtNews.setFont(new Font("Monospaced", Font.PLAIN, 14));
        txtNews.setEditable(false);
        txtNews.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        frame.add(header, BorderLayout.NORTH);
        frame.add(new JScrollPane(txtNews), BorderLayout.CENTER);
        
        JButton btnBack = new JButton("Close");
        btnBack.addActionListener(e -> frame.dispose());
        frame.add(btnBack, BorderLayout.SOUTH);

        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}


