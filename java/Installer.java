import javax.swing.JOptionPane;
import javax.swing.UIManager;
import java.awt.Color;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.nio.file.DirectoryStream;

public class Installer {
  public static void smartCopy(String sourcePath, String destPath) {
        Path source = Paths.get(sourcePath);
        Path destination = Paths.get(destPath);
        
        try {
            // Check if the source path is a directory.
            if (Files.isDirectory(source)) {
                System.out.println("--- Starting directory copy ---");
                copyDirectory(source, destination);
            } 
            // Check for wildcards in the source file name.
            else if (source.getFileName().toString().contains("*") || source.getFileName().toString().contains("?")) {
                System.out.println("--- Starting wildcard copy ---");
                Path sourceDir = source.getParent();
                String wildcard = source.getFileName().toString();
                copyFilesWithWildcard(sourceDir, destination, wildcard);
            }
            // Otherwise, assume it's a single file.
            else {
                System.out.println("--- Starting single file copy ---");
                copyFile(source, destination);
            }
        } catch (IOException e) {
            System.err.println("An error occurred during smart copy: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Copies a single file from a source path to a destination path.
     *
     * @param sourcePath The path to the source file.
     * @param destPath The path where the file will be copied.
     */
    private static void copyFile(Path sourcePath, Path destPath) throws IOException {
        Files.copy(sourcePath, destPath, StandardCopyOption.REPLACE_EXISTING);
        System.out.println("File copied successfully from " + sourcePath + " to " + destPath);
    }

    /**
     * Recursively copies a directory and its contents to a destination directory.
     * @param sourceDir The path to the source directory.
     * @param destDir The path to the destination directory.
     */
    private static void copyDirectory(Path sourceDir, Path destDir) throws IOException {
        Files.createDirectories(destDir);
        Files.walk(sourceDir)
             .forEach(sourcePath -> {
                 try {
                     Path destPath = destDir.resolve(sourceDir.relativize(sourcePath));
                     if (Files.isDirectory(sourcePath)) {
                         Files.createDirectories(destPath);
                     } else {
                         Files.copy(sourcePath, destPath, StandardCopyOption.REPLACE_EXISTING);
                     }
                     System.out.println("Copied: " + sourcePath + " to " + destPath);
                 } catch (IOException e) {
                     System.err.println("Error copying " + sourcePath + ": " + e.getMessage());
                 }
             });
    }

    /**
     * Copies all files matching a wildcard pattern from a source directory to a destination directory.
     * @param sourceDir The source directory.
     * @param destDir The destination directory.
     * @param wildcard The wildcard pattern (e.g., "*.txt").
     */
    private static void copyFilesWithWildcard(Path sourceDir, Path destDir, String wildcard) throws IOException {
        Files.createDirectories(destDir);
        try (DirectoryStream<Path> stream = Files.newDirectoryStream(sourceDir, wildcard)) {
            for (Path entry : stream) {
                if (Files.isRegularFile(entry)) {
                    Files.copy(entry, destDir.resolve(entry.getFileName()), StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("Copied file matching wildcard: " + entry.getFileName());
                }
            }
        }
    }

  private static void runCom(String[] com) {
    try {
      ProcessBuilder lsProcessBuilder = new ProcessBuilder(com);
      Process lsProcess = lsProcessBuilder.start();
      
      BufferedReader reader = new BufferedReader(new InputStreamReader(lsProcess.getInputStream()));
      String line;
      while ((line = reader.readLine()) != null) {
        System.out.println(line);
      }
      
      lsProcess.waitFor();
    } catch (IOException e) {
        System.err.println("Error executing command: " + e.getMessage());
      } catch (InterruptedException e) {
        Thread.currentThread().interrupt();
        System.err.println("Command execution was interrupted.");
      }

    }

    public static void main(String[] args) {
        String HOME= System.getenv("HOME");
        String DIR= HOME+"/.local/libs";
        boolean commandsExecuted = false;

        UIManager.put("OptionPane.background", new Color(24, 24, 37));
        UIManager.put("Panel.background", new Color(24, 24, 37));
        UIManager.put("Button.background", new Color(180, 190, 254));
        UIManager.put("Button.foreground", new Color(24, 24, 37));
        UIManager.put("OptionPane.messageForeground", new Color(137, 180, 250));


        int dialogResult = JOptionPane.showConfirmDialog(
                null,
                "Do you want to run the installation?",
                "Installer",
                JOptionPane.YES_NO_OPTION);

        if (dialogResult == JOptionPane.YES_OPTION) {
            runCom(new String[] {"mkdir", "-p", HOME+"/.local"});
            runCom(new String[] {"mkdir", "-p", DIR});
            runCom(new String[] {"mkdir", "-p", DIR+"/libIDSSVfs"});
            runCom(new String[] {"mkdir", "-p", DIR+"/libIDSSVfs/src"});
            runCom(new String[] {"mkdir", "-p", DIR+"/libIDSSVfs/header"});
            smartCopy("./lib/src/*", DIR+"/libIDSSVfs/src/");
            smartCopy("./lib/header/*", DIR+"/libIDSSVfs/header/");
            runCom(new String[] {"echo", "Install completed successfully."});
            runCom(new String[] {"echo", "Libs found at: "+DIR});
            commandsExecuted = true;
        } else {
            System.out.println("User canceled the operation. Exiting.");
        }

        if (commandsExecuted) {
            JOptionPane.showMessageDialog(null, "IDSS VFS headers successfully installed. Check the console for output.\nLibrary can be found at: "+DIR+"\nMake sure to also install libnmpp from:\nhttps://github.com/NekoMimiOfficial/NekoMimi-plus-plus\n\nNote: you'll need to include the previous directory and NMPP in cmake to use the project.", "Success", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, "Operation canceled.", "Canceled", JOptionPane.WARNING_MESSAGE);
        }
    }
}
