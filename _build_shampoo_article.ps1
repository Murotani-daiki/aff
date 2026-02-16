$ErrorActionPreference='Stop'
$root='c:\Users\daiki\.gemini\antigravity\scratch\affiliate-blog'
$txtPath='c:\Users\daiki\OneDrive\デスクトップ\サラツヤ髪になれる市販シャンプーおすすめ8選.txt'
$outFile='drugstore-shampoo-ranking.html'
$outPath=Join-Path $root $outFile

$txt=Get-Content -Raw -Encoding UTF8 $txtPath
$blockPattern='(?ms)(<table.*?</table>)\s*(https://yahoo\.jp/\S+)\s*(https://amzn\.to/\S+)'
$blocks=[regex]::Matches($txt,$blockPattern)
if($blocks.Count -ne 8){ throw "Expected 8 product blocks, got $($blocks.Count)" }

$names=@(
'いち髪 THE PREMIUM エクストラダメージケア シャンプー',
'パンテーン ミラクルズ リッチモイスチャー シャンプー',
'ダイアン パーフェクトビューティー エクストラストレート',
'ボタニスト ボタニカルシャンプー（スムース）',
'TSUBAKI プレミアムモイスト シャンプー',
'&honey（アンドハニー）ディープモイスト シャンプー',
'YOLU（ヨル）カームナイトリペア シャンプー',
'HIMAWARI（ひまわり）グロス＆リペア シャンプー'
)

$highlights=@(
'和草由来の補修成分で、パサつきとダメージを同時にケア。指通りをなめらかに整えたい人におすすめです。',
'濃密保湿タイプで、乾燥しがちな髪でもしっとりまとまりやすい仕上がり。香り重視の方にも人気です。',
'うねりや広がりを抑えて、まっすぐ感のあるツヤ髪へ。毎朝のスタイリング時間を短縮したい人向けです。',
'軽やかな洗い上がりで、サラサラ質感を重視する人に相性が良い一本。ドラッグストアで入手しやすい定番です。',
'毛先のパサつきが気になる髪をしっとり補修。コスパと仕上がりのバランスが高い人気シリーズです。',
'ハチミツ由来の保湿設計で、しっとりまとまりとツヤ感を両立。乾燥毛・ダメージ毛のケアに向いています。',
'夜の摩擦ダメージを意識したナイトケア処方。朝のまとまりを改善したい人に選ばれています。',
'髪のゆがみを整える設計で、広がりやごわつきをケア。扱いやすいサラツヤ髪を目指す方向けです。'
)
$badges=@('👑 総合バランス','🥇 保湿重視','🥈 うねり対策','🥉 サラサラ重視','✨ コスパ優秀','🍯 高保湿ケア','🌙 ナイトケア','🌻 広がりケア')

$toc=@()
$sections=@()
for($i=0;$i -lt 8;$i++){
  $rank=$i+1
  $id="product$rank"
  $name=[System.Net.WebUtility]::HtmlEncode($names[$i])
  $toc += "                        <li><a href='#$id'>$rank. $name</a></li>"

  $table=$blocks[$i].Groups[1].Value.Trim()
  $yahoo=$blocks[$i].Groups[2].Value.Trim()
  $amazon=$blocks[$i].Groups[3].Value.Trim()

  $sections += @"
                <div class="article-section" id="$id">
                    <h2 class="article-h2"><span class="h2-icon">$rank️⃣</span> 第${rank}位：$name</h2>
                    <div class="product-rank-badge rank-$rank">$($badges[$i])</div>
                    <div class="product-review-card">
                        <h3>$name</h3>
                        <p>$($highlights[$i])</p>
                        <p>シャンプー選びは「洗浄力」「仕上がり」「香り」の3点を基準にすると、自分の髪質に合う1本を見つけやすくなります。</p>
                    </div>
                    <div class="affiliate-banner-wrapper">
                        <h4 class="affiliate-label">🛒 この商品を購入する</h4>
                        <div class="affiliate-banner">
$table
                        </div>
                        <div class="affiliate-btns-flex">
                            <a href="$amazon" target="_blank" rel="nofollow sponsored noopener" class="amazon-btn">
                                <span class="amazon-icon"><i class="fa-brands fa-amazon"></i></span> Amazonで購入
                            </a>
                            <a href="$yahoo" target="_blank" rel="nofollow sponsored noopener" class="yahoo-shopping-btn">
                                <span class="yahoo-icon">Y!</span> Yahoo!で見る
                            </a>
                        </div>
                    </div>
                </div>
"@
}

$html=@"
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>サラツヤ髪になれる市販シャンプーおすすめ8選 | BestPick</title>
    <meta name="description" content="ドラッグストアで買える市販シャンプーのおすすめ8選。いち髪、パンテーン、ダイアン、BOTANIST、TSUBAKI、&honey、YOLU、HIMAWARIを比較。">
    <meta name="keywords" content="市販シャンプー,おすすめ,サラツヤ髪,ドラッグストア,いち髪,パンテーン,ダイアン,BOTANIST,TSUBAKI,&honey,YOLU,HIMAWARI">
    <meta name="author" content="BestPick">
    <link rel="canonical" href="https://bestpick-blog.com/$outFile">
    <meta property="og:title" content="サラツヤ髪になれる市販シャンプーおすすめ8選">
    <meta property="og:description" content="人気の市販シャンプー8商品を購入リンク付きで比較。">
    <meta property="og:type" content="article">
    <meta property="og:locale" content="ja_JP">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&family=Noto+Sans+JP:wght@400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="article.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <nav class="navbar" id="navbar">
        <div class="container">
            <a href="index.html" class="nav-logo"><span class="nav-logo-icon">✦</span> BestPick</a>
            <div class="nav-links" id="navLinks">
                <a href="index.html">ホーム</a>
                <a href="index.html#gadgets">ガジェット</a>
                <a href="index.html#beauty">美容</a>
                <a href="index.html#fashion">ファッション</a>
            </div>
            <button class="nav-hamburger" id="navHamburger" aria-label="メニュー">☰</button>
        </div>
    </nav>

    <section class="article-hero">
        <div class="container">
            <div class="article-breadcrumb">
                <a href="index.html">ホーム</a> <span>›</span>
                <a href="index.html#beauty">美容・コスメ</a> <span>›</span>
                <span class="current">市販シャンプー</span>
            </div>
            <span class="article-category-badge beauty">🧴 ヘアケア</span>
            <h1 class="article-title">サラツヤ髪になれる<br><span class="gradient">市販シャンプー</span>おすすめ8選</h1>
            <div class="article-meta-row">
                <span class="article-date">📅 2026.02.16</span>
                <span class="article-reading-time">⏱ 読了目安：8分</span>
                <div class="article-stars">★★★★★ <span>4.7</span></div>
            </div>
        </div>
    </section>

    <section class="article-layout">
        <div class="container">
            <div class="article-main">
                <div class="article-hero-img-wrapper">
                    <img src="https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=1200&h=675&fit=crop" alt="市販シャンプー" class="article-hero-img">
                </div>

                <div class="article-lead">
                    <p>サラツヤ髪を目指す人向けに、ドラッグストアで手に入りやすい市販シャンプーを8商品に絞って比較しました。</p>
                    <p>本記事では、指定テキストに掲載されていた商品情報と購入リンクをそのまま整理しています。</p>
                </div>

                <div class="article-toc">
                    <h2 class="toc-title">📋 この記事の目次</h2>
                    <ol class="toc-list">
$($toc -join "`n")
                        <li><a href="#conclusion">まとめ</a></li>
                    </ol>
                </div>

$($sections -join "`n")

                <div class="article-section" id="conclusion">
                    <h2 class="article-h2"><span class="h2-icon">📝</span> まとめ</h2>
                    <div class="conclusion-box">
                        <p>市販シャンプーでも、髪質に合う製品を選べばサラツヤ感は十分に目指せます。</p>
                        <p>まずは気になる1本を2〜4週間継続して、指通り・まとまり・頭皮状態の変化で相性を確認するのがおすすめです。</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="site-footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <a href="index.html" class="nav-logo"><span class="nav-logo-icon">✦</span> BestPick</a>
                    <p>実際に使って良いと感じた商品だけを厳選レビュー。あなたのベストな買い物をお手伝いします。</p>
                </div>
                <div class="footer-col">
                    <h4>カテゴリ</h4>
                    <a href="index.html#gadgets">ガジェット</a>
                    <a href="index.html#beauty">美容・コスメ</a>
                    <a href="index.html#fashion">ファッション</a>
                    <a href="index.html#food">グルメ・食品</a>
                </div>
                <div class="footer-col">
                    <h4>サイト情報</h4>
                    <a href="#">運営者情報</a>
                    <a href="#">プライバシーポリシー</a>
                    <a href="#">お問い合わせ</a>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 BestPick All Rights Reserved. | 当サイトはアフィリエイトプログラムに参加しています。</p>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const hamburger = document.getElementById('navHamburger');
            const navLinks = document.getElementById('navLinks');
            if (hamburger && navLinks) {
                hamburger.addEventListener('click', () => {
                    navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
                    navLinks.style.flexDirection = 'column';
                    navLinks.style.position = 'absolute';
                    navLinks.style.top = '64px';
                    navLinks.style.left = '0';
                    navLinks.style.right = '0';
                    navLinks.style.background = 'rgba(15, 15, 26, 0.98)';
                    navLinks.style.padding = '20px';
                    navLinks.style.gap = '16px';
                    navLinks.style.borderBottom = '1px solid rgba(255,255,255,0.1)';
                    navLinks.style.zIndex = '999';
                });
            }
            document.querySelectorAll('.toc-list a').forEach(link => {
                link.addEventListener('click', (e) => {
                    e.preventDefault();
                    const target = document.querySelector(link.getAttribute('href'));
                    if (target) target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                });
            });
        });
    </script>
</body>
</html>
"@

Set-Content -Path $outPath -Value $html -Encoding UTF8

$indexPath=Join-Path $root 'index.html'
$index=Get-Content -Raw -Encoding UTF8 $indexPath
$old=@"
                                <h3 class="product-card-title"><a href="#">サラツヤ髪になれる！市販シャンプーおすすめ8選</a></h3>
                                <p class="product-card-excerpt">ドラッグストアで買えるシャンプーの中から、成分・仕上がり・香りで選ぶおすすめを紹介。</p>
                                <div class="product-card-meta">
                                    <span class="product-card-price">¥980〜</span>
                                    <a href="#" class="product-card-link">詳細 →</a>
                                </div>
"@
$new=@"
                                <h3 class="product-card-title"><a href="$outFile">サラツヤ髪になれる！市販シャンプーおすすめ8選</a></h3>
                                <p class="product-card-excerpt">ドラッグストアで買えるシャンプーの中から、成分・仕上がり・香りで選ぶおすすめを紹介。</p>
                                <div class="product-card-meta">
                                    <span class="product-card-price">¥980〜</span>
                                    <a href="$outFile" class="product-card-link">詳細 →</a>
                                </div>
"@
$index=$index.Replace($old,$new)
Set-Content -Path $indexPath -Value $index -Encoding UTF8

$sitemapPath=Join-Path $root 'sitemap.xml'
$sitemap=Get-Content -Raw -Encoding UTF8 $sitemapPath
if($sitemap -notmatch [regex]::Escape($outFile)){
$node=@"
  <url>
    <loc>https://blog.html-master.com/$outFile</loc>
    <lastmod>2026-02-16</lastmod>
    <priority>0.7</priority>
  </url>
"@
  $sitemap=$sitemap.Replace('</urlset>',"$node`n</urlset>")
  Set-Content -Path $sitemapPath -Value $sitemap -Encoding UTF8
}

Write-Host 'ok'
