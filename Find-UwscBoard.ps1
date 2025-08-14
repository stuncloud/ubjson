<#
    .SYNOPSIS
    掲示板ログのjsonファイルを検索するスクリプト
    .DESCRIPTION
    タイトル及び本文から任意の単語にマッチする投稿を抽出します
    オプションで投稿者および投稿日時によるフィルタが可能です
    .EXAMPLE
    ./Find-UwscBoard.ps1 -Query fizzbuzz
    # fizzbuzzを含む投稿を抽出する
    .EXAMPLE
    ./Find-UwscBoard.ps1 -Query fizzbuzz -author stuncloud
    # fizzbuzzを含む投稿のうち投稿者がstuncloudのものを抽出する
    .EXAMPLE
    .\Find-UwscBoard.ps1 -Author stuncloud -Query fizzbuzz -Since 2017/12/15 -Until 2017/12/16
    # fizzbuzzを含む投稿のうち投稿者がstuncloudで投稿日が2017/12/15であるものを抽出する
    .OUTPUTS
    [BoardLog]
#>
[OutputType()]
[CmdletBinding()]
param(
    # 検索単語
    # 投稿のタイトルと本文のうち単語がマッチしたものを抽出します
    [Parameter(Mandatory=$false)]
    [string] $Query,
    # 投稿者フィルタ
    # 名前がマッチする投稿者の投稿のみを抽出します
    [Parameter(Mandatory=$false)]
    [string] $Author,
    # 日時フィルタ
    # 指定日時以降の投稿を抽出します
    [Parameter(Mandatory=$false)]
    [datetime] $Since = [datetime]::new(0),
    # 日時フィルタ
    # 指定日時以前の投稿を抽出します
    [Parameter(Mandatory=$false)]
    [datetime] $Until = [datetime]::Now
)
begin {
    class BoardLog {
        <# Define the class. Try constructors, properties, or methods. #>
        [string] $Title
        [string] $Author
        [int] $No
        [datetime] $DateTime
        [string] $Content

        BoardLog([psobject] $obj) {
            $this.Title = $obj.title
            $this.Author = $obj.author
            $this.No = $obj.no
            $this.DateTime = $obj.datetime ? [datetime] $obj.datetime.Replace("(", " ").Replace(")", "") : [datetime]::new(1)
            $this.Content = $obj.content
        }

        [bool] MatchesTo(
            [string] $Query,
            [string] $Author,
            [datetime] $Since,
            [datetime] $Until
        ) {
            if ($Author -and $this.Author -notmatch $Author) {
                return $false
            }
            if ($this.DateTime -le $Since) {
                return $false
            }
            if ($this.DateTime -ge $Until) {
                return $false
            }
            return ($this.Title -match $Query) -or ($this.Content -match $Query)
        }
    }
    $UB = $PSScriptRoot | Join-Path -ChildPath .\ub.json | Get-Item | Get-Content -Raw | ConvertFrom-Json
    $UBOld = $PSScriptRoot | Join-Path -ChildPath .\ub_old.json | Get-Item | Get-Content -Raw | ConvertFrom-Json
}
end {
    $UB.board | ForEach-Object {[BoardLog]::new($_)} | Where-Object {$_.MatchesTo($Query, $Author, $Since, $Until)}
    $UB.board | ForEach-Object {[BoardLog]::new($_)} | Where-Object {$_.MatchesTo($Query, $Author, $Since, $Until)}
    $UB.board.response | ForEach-Object {[BoardLog]::new($_)} | Where-Object {$_.MatchesTo($Query, $Author, $Since, $Until)}
    $UB.log | ForEach-Object {[BoardLog]::new($_)} | Where-Object {$_.MatchesTo($Query, $Author, $Since, $Until)}
    $UB.log.response | ForEach-Object {[BoardLog]::new($_)} | Where-Object {$_.MatchesTo($Query, $Author, $Since, $Until)}
    $UBOld.board | ForEach-Object {[BoardLog]::new($_)} | Where-Object {$_.MatchesTo($Query, $Author, $Since, $Until)}
    $UBOld.board.response | ForEach-Object {[BoardLog]::new($_)} | Where-Object {$_.MatchesTo($Query, $Author, $Since, $Until)}
}
