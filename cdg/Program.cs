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
        {
            choices.Add("__UP__");
        }

        choices.Add("__Exit__");
        choices.AddRange(dirs);

        var selection = AnsiConsole.Prompt(
            new SelectionPrompt<string>()
                .Title($"Current: {path}")
                .PageSize(20)
                .AddChoices(choices));

        if (selection == "__Exit__")
        {
            Console.WriteLine(path);
            return "__EXIT__";
        }

        if (selection == "__UP__")
            return parent?.FullName;

        return Path.Combine(path, selection);
    }
}