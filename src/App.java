import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;



import java.util.EnumMap;
import java.util.Map;

public class App extends JFrame {
    private static final int QR_SIZE = 320;

    private final JTextField urlField = new JTextField();
    private final JLabel qrPreview = new JLabel();
    private BufferedImage lastImage;

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            setSystemLookAndFeel();
            new App().setVisible(true);
        });
    }

    private static void setSystemLookAndFeel() {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException
                | UnsupportedLookAndFeelException ignored) {
            // Fallback to default look and feel.
        }
    }

    public App() {
        super("QR Generator");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setPreferredSize(new Dimension(540, 520));
        setLayout(new BorderLayout(12, 12));

        JPanel content = new JPanel(new GridBagLayout());
        content.setBorder(BorderFactory.createEmptyBorder(16, 16, 16, 16));

        GridBagConstraints gc = new GridBagConstraints();
        gc.insets = new Insets(8, 8, 8, 8);
        gc.fill = GridBagConstraints.HORIZONTAL;

        JLabel title = new JLabel("Link to QR");
        title.setFont(title.getFont().deriveFont(Font.BOLD, 18f));
        gc.gridx = 0;
        gc.gridy = 0;
        gc.gridwidth = 2;
        content.add(title, gc);

        JLabel subtitle = new JLabel("Paste a URL, generate a QR, then save as PNG.");
        subtitle.setForeground(new Color(80, 80, 80));
        gc.gridy = 1;
        content.add(subtitle, gc);

        JLabel urlLabel = new JLabel("Link");
        gc.gridy = 2;
        gc.gridwidth = 1;
        content.add(urlLabel, gc);

        urlField.setColumns(28);
        urlField.putClientProperty("JComponent.sizeVariant", "large");
        gc.gridx = 1;
        content.add(urlField, gc);

        JPanel buttons = new JPanel();
        buttons.setLayout(new BoxLayout(buttons, BoxLayout.X_AXIS));
        JButton generateButton = new JButton("Generate");
        JButton saveButton = new JButton("Save PNG");
        buttons.add(generateButton);
        buttons.add(Box.createRigidArea(new Dimension(8, 0)));
        buttons.add(saveButton);

        gc.gridx = 0;
        gc.gridy = 3;
        gc.gridwidth = 2;
        content.add(buttons, gc);

        qrPreview.setHorizontalAlignment(JLabel.CENTER);
        qrPreview.setVerticalAlignment(JLabel.CENTER);
        qrPreview.setOpaque(true);
        qrPreview.setBackground(new Color(245, 245, 245));
        qrPreview.setBorder(BorderFactory.createLineBorder(new Color(220, 220, 220), 1));
        qrPreview.setPreferredSize(new Dimension(QR_SIZE + 20, QR_SIZE + 20));

        gc.gridy = 4;
        gc.weighty = 1.0;
        gc.fill = GridBagConstraints.BOTH;
        content.add(qrPreview, gc);

        add(content, BorderLayout.CENTER);

        generateButton.addActionListener(e -> handleGenerate());
        saveButton.addActionListener(e -> handleSave());

        pack();
        setLocationRelativeTo(null);
    }

    private void handleGenerate() {
        String text = urlField.getText().trim();
        if (text.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please enter a link to encode.", "Missing link",
                    JOptionPane.WARNING_MESSAGE);
            return;
        }

        try {
            lastImage = renderQr(text, QR_SIZE);
            qrPreview.setIcon(new javax.swing.ImageIcon(lastImage));
        } catch (WriterException ex) {
            JOptionPane.showMessageDialog(this, "Could not generate QR: " + ex.getMessage(), "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    private void handleSave() {
        if (lastImage == null) {
            JOptionPane.showMessageDialog(this, "Generate a QR first.", "Nothing to save",
                    JOptionPane.INFORMATION_MESSAGE);
            return;
        }

        JFileChooser chooser = new JFileChooser();
        chooser.setDialogTitle("Save QR Code");
        chooser.setSelectedFile(new File("qr-code.png"));

        if (chooser.showSaveDialog(this) == JFileChooser.APPROVE_OPTION) {
            File file = chooser.getSelectedFile();
            if (!file.getName().toLowerCase().endsWith(".png")) {
                file = new File(file.getParentFile(), file.getName() + ".png");
            }

            try {
                ImageIO.write(lastImage, "png", file);
                JOptionPane.showMessageDialog(this, "Saved to: " + file.getAbsolutePath(), "Saved",
                        JOptionPane.INFORMATION_MESSAGE);
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Could not save file: " + ex.getMessage(), "Save error",
                        JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    private BufferedImage renderQr(String text, int size) throws WriterException {
        QRCodeWriter writer = new QRCodeWriter();
        Map<EncodeHintType, Object> hints = new EnumMap<>(EncodeHintType.class);
        hints.put(EncodeHintType.MARGIN, 1);
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);

        BitMatrix matrix = writer.encode(text, com.google.zxing.BarcodeFormat.QR_CODE, size, size, hints);
        return toImage(matrix);
    }

    private BufferedImage toImage(BitMatrix matrix) {
        int width = matrix.getWidth();
        int height = matrix.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);
        g.setColor(Color.BLACK);

        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                if (matrix.get(x, y)) {
                    g.fillRect(x, y, 1, 1);
                }
            }
        }

        g.dispose();
        return image;
    }
}
