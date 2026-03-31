using Spectre.Console;

namespace cdg;

class Program
{
    static void Main(string[] args)
    {
        AnsiConsole.Console = AnsiConsole.Create(new AnsiConsoleSettings
        {
            Out = new AnsiConsoleOutput(Console.Error)
        });
        string current = Directory.GetCurrentDirectory();
        
        current = HandleArgs(args, current);
        
        while (true)
        {
            var next = ShowMenu(current);

            if (next == null)
                return;

            if (next == "__EXIT__")
                return;

            current = next;
        }
    }

    static string? ShowMenu(string path)
    {
        var parent = Directory.GetParent(path);

        var dirs = Directory.GetDirectories(path)
            .Select(Path.GetFileName)
            .ToList();

        var choices = new List<string>();

        if (parent != null)
            choices.Add("../");

        choices.Add("./");
        choices.AddRange(dirs!);

        var selection = AnsiConsole.Prompt(
            new SelectionPrompt<string>()
                .Title($"Current: {path}")
                .PageSize(20)
                .AddChoices(choices));

        if (selection == "./")
        {
            Console.WriteLine(path);
            return "__EXIT__";
        }

        if (selection == "../")
            return parent?.FullName;

        return Path.Combine(path, selection);
    }

    public static string HandleArgs(string[] args, string current)
    {
        if (args.Length == 0)
            return current;

        switch (args[0])
        {
            case "-h":
                Console.WriteLine(@"
Usage: cdg [options]

Options:
    -h            Help menu
    -b <name>     Bookmark current directory
    -b            List all bookmarks
    <name>        Jump to a bookmarked directory

Example:
    cdg -b photos
    cdg photos
");
                Environment.Exit(0);
                break;

            case "-b":
                if (args.Length < 2)
                    ShowBookmarks();
                else
                    SaveBookmark(current, args[1]);

                Environment.Exit(0);
                break;

            default:
                string path = FindBookmark(args[0]);
                Console.WriteLine(path);
                Environment.Exit(0);
                break;
        }

        return current;
    }

    static string BookmarkPath()
    {
        string home = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
        return Path.Combine(home, ".local", "bin", "bookmarks.txt");
    }

    public static void ShowBookmarks()
    {
        string file = BookmarkPath();
        if (!File.Exists(file))
            return;

        foreach (var line in File.ReadAllLines(file))
            Console.WriteLine(line);
    }

    public static string FindBookmark(string key)
    {
        string file = BookmarkPath();
        if (!File.Exists(file))
        {
            Console.Error.WriteLine($"No bookmarks file found");
            Environment.Exit(1);
        }

        foreach (var line in File.ReadAllLines(file))
        {
            var parts = line.Split(':', 2);
            if (parts.Length == 2 && parts[0] == key)
                return parts[1];
        }

        Console.Error.WriteLine($"Bookmark '{key}' not found");
        Environment.Exit(1);
        return "";
    }

    public static void SaveBookmark(string path, string name)
    {
        string file = BookmarkPath();
        Directory.CreateDirectory(Path.GetDirectoryName(file)!);

        var lines = File.Exists(file)
            ? File.ReadAllLines(file).Where(l => !l.StartsWith($"{name}:")).ToList()
            : new List<string>();

        lines.Add($"{name}:{path}");
        File.WriteAllLines(file, lines);

        Console.Error.WriteLine($"Saved bookmark '{name}' -> {path}");
    }
}