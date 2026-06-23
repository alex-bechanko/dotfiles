{ config, lib, ... }:
{
  config.programs.claude-code.settings = lib.mkIf config.programs.claude-code.enable {
    mcpServers = {
      atlassian = {
        type = "http";
        url = "https://mcp.atlassian.com/mcp";
      };
    };
    permissions = {
      allow = [
        "WebSearch"
        "WebFetch"
        "Read"
        "Glob"
        "Grep"
        "Bash(git status:*)"
        "Bash(git log:*)"
        "Bash(git diff:*)"
        "Bash(git branch:*)"
        "Bash(git show:*)"
        "Bash(cargo:*)"
        "Bash(jj status:*)"
        "Bash(jj log:*)"
        "Bash(jj diff:*)"
        "Bash(jj show:*)"
        "Bash(jj bookmark list:*)"
        "Bash(nix eval:*)"
        "Bash(nix flake show:*)"
        "Bash(nix flake metadata:*)"
        "Bash(nix flake info:*)"
        "Bash(nix flake check:*)"
        "Bash(nix search:*)"
        "Bash(nix path-info:*)"
        "Bash(nix derivation show:*)"
        "Bash(nix store ls:*)"
        "Bash(nix why-depends:*)"
        "Bash(gh pr view:*)"
        "Bash(gh pr list:*)"
        "Bash(gh pr diff:*)"
        "Bash(gh pr checks:*)"
        "Bash(gh issue view:*)"
        "Bash(gh issue list:*)"
        "Bash(gh run list:*)"
        "Bash(gh run view:*)"
        "Bash(gh release list:*)"
        "Bash(gh release view:*)"
        "Bash(gh repo view:*)"
        "Bash(gh api repos:*)"

        # Atlassian MCP - read/search only
        "mcp__claude_ai_Atlassian__atlassianUserInfo"
        "mcp__claude_ai_Atlassian__getAccessibleAtlassianResources"
        "mcp__claude_ai_Atlassian__search"
        "mcp__claude_ai_Atlassian__fetch"
        "mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql"
        "mcp__claude_ai_Atlassian__getJiraIssue"
        "mcp__claude_ai_Atlassian__getVisibleJiraProjects"
        "mcp__claude_ai_Atlassian__getJiraIssueRemoteIssueLinks"
        "mcp__claude_ai_Atlassian__getJiraProjectIssueTypesMetadata"
        "mcp__claude_ai_Atlassian__getJiraIssueTypeMetaWithFields"
        "mcp__claude_ai_Atlassian__getIssueLinkTypes"
        "mcp__claude_ai_Atlassian__getTransitionsForJiraIssue"
        "mcp__claude_ai_Atlassian__getConfluencePage"
        "mcp__claude_ai_Atlassian__getConfluenceSpaces"
        "mcp__claude_ai_Atlassian__getPagesInConfluenceSpace"
        "mcp__claude_ai_Atlassian__getConfluencePageDescendants"
        "mcp__claude_ai_Atlassian__searchConfluenceUsingCql"
        "mcp__claude_ai_Atlassian__getConfluencePageFooterComments"
        "mcp__claude_ai_Atlassian__getConfluencePageInlineComments"
        "mcp__claude_ai_Atlassian__getConfluenceCommentChildren"
      ];
    };
  };
}
