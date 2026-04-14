import javax.swing.*;
import java.awt.*;

public class DocumentRequests {
    public void showWindow() {
        JFrame frame = new JFrame("Barangay San Marino - Document Requests");
        frame.setSize(600, 500);
        frame.setLayout(new BorderLayout(10, 10));

        JPanel header = new JPanel();
        header.setBackground(new Color(52, 152, 219)); // Blue
        JLabel title = new JLabel("DOCUMENT REQUEST TERMINAL");
        title.setFont(new Font("Segoe UI", Font.BOLD, 20));
        title.setForeground(Color.WHITE);
        header.add(title);

        JPanel form = new JPanel(new GridLayout(5, 1, 10, 10));
        form.setBorder(BorderFactory.createEmptyBorder(20, 50, 20, 50));

        JTextField txtName = new JTextField();
        txtName.setBorder(BorderFactory.createTitledBorder("Resident Name"));

        String[] docs = {"Barangay Clearance", "Certificate of Indigency", "Barangay ID", "Business Permit"};
        JComboBox<String> cbDocs = new JComboBox<>(docs);
        cbDocs.setBorder(BorderFactory.createTitledBorder("Select Document"));

        JTextField txtPurpose = new JTextField();
        txtPurpose.setBorder(BorderFactory.createTitledBorder("Purpose of Request"));

        JButton btnSubmit = new JButton("Submit Request");
        btnSubmit.setBackground(new Color(46, 204, 113));
        btnSubmit.setForeground(Color.WHITE);

        form.add(txtName); form.add(cbDocs); form.add(txtPurpose); form.add(btnSubmit);

        frame.add(header, BorderLayout.NORTH);
        frame.add(form, BorderLayout.CENTER);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}

