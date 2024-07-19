-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-12-06 11:53:00
-- 伺服器版本： 10.4.22-MariaDB
-- PHP 版本： 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫: `blacknwhite`
--

-- --------------------------------------------------------

--
-- 資料表結構 `articlecontents`
--

CREATE TABLE `articlecontents` (
  `a_id` int(11) NOT NULL,
  `a_sidebar_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `a_level` int(11) DEFAULT NULL,
  `a_parent` int(11) DEFAULT NULL,
  `a_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `a_content` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `a_tagName` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `a_image_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `a_editMode` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `a_account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `a_datetime` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `a_deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `articlecontents`
--

INSERT INTO `articlecontents` (`a_id`, `a_sidebar_name`, `a_level`, `a_parent`, `a_title`, `a_content`, `a_tagName`, `a_image_url`, `a_editMode`, `a_account`, `a_datetime`, `a_deleted`) VALUES
(4, '世界觀', NULL, NULL, 'DOMPurify、CSP 和 HttpOnly Secure Cookie', '<p>@@! test&nbsp;</p>', NULL, NULL, 'normal', 'et', NULL, 0),
(5, '種族', NULL, NULL, '種族', '<p>種族種族種族</p>', NULL, NULL, 'normal', 'et', NULL, 0),
(6, '地圖', NULL, NULL, '你好', '<p><img src=\"https://images.plurk.com/7q4SSiOcwVH3S1LN2ZAGO9.jpg\" alt=\"\" width=\"720\" height=\"960\"></p>', '', '', NULL, 'et', '', 0),
(7, '事件紀錄', NULL, NULL, '', '', '', '', 'event', 'et', '', 0),
(8, '圖書館資料', NULL, NULL, '狗狗貓貓資料', '<ol>\n<li>https://juejin.cn/post/6999525569708687374</li>\n</ol>\n<ul>\n<li>https://juejin.cn/post/6999525569708687374</li>\n</ul>\n<p>https://juejin.cn/post/6999525569708687374</p>\n<p>https://juejin.cn/post/6999525569708687374</p>\n<p><span style=\"text-decoration: underline;\"><em>https://juejin.cn/post/6999525569708687374</em></span></p>\n<p style=\"padding-left: 40px;\"><span style=\"text-decoration: underline;\"><em><a href=\"http://localhost/phpmyadmin/index.php?route=/sql&amp;amp;db=blacknwhite&amp;amp;table=users&amp;amp;pos=0\">https://juejin.cn/post/6999525569708687374</a></em></span></p>\n<ol>\n<li>https://juejin.cn/post/6999525569708687374</li>\n<li>&nbsp;</li>\n</ol>\n<ul>\n<li>https://juejin.cn/post/6999525569708687374</li>\n</ul>\n<p>是一種可通過<a class=\"mw-redirect\" title=\"瀏覽器\" href=\"https://zh.wikipedia.org/wiki/%E6%B5%8F%E8%A7%88%E5%99%A8\">瀏覽器</a></p>\n<p><code>[123](https://juejin.cn/post/6999525569708687374)</code></p>', NULL, NULL, 'normal', 'et', NULL, 0),
(15, '世界介紹', 1, 4, '世界觀介紹', '<p style=\"margin-top: 0pt; margin-bottom: 3pt;\"><span style=\"font-size: 26pt; font-family: Arial, sans-serif;\">《楔子》</span></p>\n<p>&nbsp;</p>\n<p style=\"margin-top: 0pt; margin-bottom: 0pt;\"><em><span style=\"font-size: 12pt; font-family: Arial, sans-serif;\">毫無生靈的土地，一望無際的闐暗。</span></em></p>\n<p>&nbsp;</p>\n<p style=\"margin-top: 0pt; margin-bottom: 0pt;\"><em><span style=\"font-size: 12pt; font-family: Arial, sans-serif;\">黑龍與白龍誕生之際，巨大的體型使地殼摩擦、膨脹、爆炸，水誕下新生、火重塑形體、黑白雙魂注入靈魂，最終一陣虹光降下，賦予眾生智慧。</span></em></p>\n<p>&nbsp;</p>\n<p style=\"margin-top: 0pt; margin-bottom: 0pt;\"><em><span style=\"font-size: 12pt; font-family: Arial, sans-serif;\">無人知曉其雙龍目的為何，它們僅為獲得一切感到欣喜。</span></em></p>\n<p>&nbsp;</p>\n<p style=\"margin-top: 0pt; margin-bottom: 0pt;\"><em><span style=\"font-size: 12pt; font-family: Arial, sans-serif;\">阿，萬物眾靈皆受吾等恩施，皆臣服吾等之下</span></em></p>\n<p>&nbsp;</p>\n<p style=\"margin-top: 0pt; margin-bottom: 0pt;\"><em><span style=\"font-size: 12pt; font-family: Arial, sans-serif;\">萬物阿，欣喜吧，為那無法預測的新世界拓展，一切皆為滿足我兩那無止盡的慾望。</span></em></p>', NULL, NULL, 'normal', 'et', NULL, 0),
(16, '天界', 1, 5, '天界', '<p>天界</p>', '', '', 'normal', 'et', '', 0),
(17, '龍', 2, 16, '龍', '<p>龍</p>', NULL, NULL, 'normal', 'et', NULL, 0),
(18, '人界', 1, 5, '人界', '<p>人界</p>', NULL, NULL, 'normal', 'et', NULL, 0),
(19, '人', 2, 18, '23', '<p>22222222222222222222222222222</p>', '', '', NULL, 'et', '', 0),
(21, '重大事件', 1, 7, '重大事件1', '<p>test1</p>', '[\"123\",\"1234456\",\"123444\"]', 'https://igiyou.com/xdogs/view/data/image/dog/g21.jpg', 'event', 'et', '2023-11-06', 0),
(33, '刪除的', 1, 4, NULL, NULL, NULL, NULL, NULL, 'et', NULL, 1),
(34, '刪除用1', 1, 4, '123', '<p>123</p>', NULL, NULL, 'normal', 'et', NULL, 1),
(36, '你是狗兒子', 1, 35, NULL, NULL, NULL, NULL, NULL, 'et', NULL, 1),
(37, '文章1', 2, 21, '天安門事件', '<p><strong>六四事件</strong>，又稱<strong>八九民運</strong>、<strong>八九學運</strong>，中國官方稱<strong>1989年春夏之交的政治風波</strong>，廣義上指1989年4月中旬開始的以<a title=\"對胡耀邦的紀念活動\" href=\"https://zh.wikipedia.org/wiki/%E5%AF%B9%E8%83%A1%E8%80%80%E9%82%A6%E7%9A%84%E7%BA%AA%E5%BF%B5%E6%B4%BB%E5%8A%A8\">悼念胡耀邦活動</a>為導火線、由<a title=\"中國大陸高等學校列表\" href=\"https://zh.wikipedia.org/wiki/%E4%B8%AD%E5%9B%BD%E5%A4%A7%E9%99%86%E9%AB%98%E7%AD%89%E5%AD%A6%E6%A0%A1%E5%88%97%E8%A1%A8\">中國大陸高校</a>學生在<a title=\"北京市\" href=\"https://zh.wikipedia.org/wiki/%E5%8C%97%E4%BA%AC%E5%B8%82\">北京市</a><a title=\"天安門廣場\" href=\"https://zh.wikipedia.org/wiki/%E5%A4%A9%E5%AE%89%E9%97%A8%E5%B9%BF%E5%9C%BA\">天安門廣場</a>發起、持續近兩個月的<a title=\"\" href=\"https://zh.wikipedia.org/wiki/%E4%B8%AD%E8%8F%AF%E4%BA%BA%E6%B0%91%E5%85%B1%E5%92%8C%E5%9C%8B%E6%B0%91%E4%B8%BB%E9%81%8B%E5%8B%95\">全境示威運動</a><sup id=\"cite_ref-趙紫陽_9-0\"><a href=\"https://zh.wikipedia.org/zh-tw/%E5%85%AD%E5%9B%9B%E4%BA%8B%E4%BB%B6#cite_note-%E8%B6%99%E7%B4%AB%E9%99%BD-9\">[9]</a></sup><sup id=\"cite_ref-:1_10-0\"><a href=\"https://zh.wikipedia.org/zh-tw/%E5%85%AD%E5%9B%9B%E4%BA%8B%E4%BB%B6#cite_note-:1-10\">[10]</a></sup><sup id=\"cite_ref-獨立電視服務_11-0\"><a href=\"https://zh.wikipedia.org/zh-tw/%E5%85%AD%E5%9B%9B%E4%BA%8B%E4%BB%B6#cite_note-%E7%8D%A8%E7%AB%8B%E9%9B%BB%E8%A6%96%E6%9C%8D%E5%8B%99-11\">[11]</a></sup>。狹義上指<strong><a title=\"六四清場\" href=\"https://zh.wikipedia.org/wiki/%E5%85%AD%E5%9B%9B%E6%B8%85%E5%9C%BA\">六四清場</a></strong>，即1989年6月3日晚間至6月4日凌晨，<a title=\"中國人民解放軍\" href=\"https://zh.wikipedia.org/wiki/%E4%B8%AD%E5%9B%BD%E4%BA%BA%E6%B0%91%E8%A7%A3%E6%94%BE%E5%86%9B\">中國人民解放軍</a>、<a title=\"中國人民武裝警察部隊\" href=\"https://zh.wikipedia.org/wiki/%E4%B8%AD%E5%9B%BD%E4%BA%BA%E6%B0%91%E6%AD%A6%E8%A3%85%E8%AD%A6%E5%AF%9F%E9%83%A8%E9%98%9F\">武裝警察部隊</a>和<a title=\"中華人民共和國人民警察\" href=\"https://zh.wikipedia.org/wiki/%E4%B8%AD%E5%8D%8E%E4%BA%BA%E6%B0%91%E5%85%B1%E5%92%8C%E5%9B%BD%E4%BA%BA%E6%B0%91%E8%AD%A6%E5%AF%9F\">人民警察</a>在北京天安門廣場對<a title=\"示威\" href=\"https://zh.wikipedia.org/wiki/%E7%A4%BA%E5%A8%81\">示威</a>集會進行的武力清場行動</p>', '[\"天安門\",\"坦克車\",\"習近平\"]', 'https://imagedelivery.net/UYQOTZcPn8gGeaNtnHVGeg/6b3f8a51-788a-42b3-3e58-9a129034be00/w=1024,quality=90,metadata=keep', 'event', 'et', '1989-06-04', 0),
(38, '世界時間軸', 1, 7, NULL, NULL, NULL, NULL, 'timeline', 'et', NULL, 1),
(39, '文章2', 2, 21, '二二八事件', '<p><strong>二二八事件</strong><span id=\"noteTag-cite_ref-sup\"><sup id=\"cite_ref-3\"><a href=\"https://zh.wikipedia.org/zh-tw/%E4%BA%8C%E4%BA%8C%E5%85%AB%E4%BA%8B%E4%BB%B6#cite_note-3\">[註 1]</a></sup></span>是指1947年2月27日至5月16日間，<a title=\"臺灣\" href=\"https://zh.wikipedia.org/wiki/%E8%87%BA%E7%81%A3\">臺灣</a>各地爆發激烈的官民衝突，民眾要求政治改革，最終<a title=\"中華民國\" href=\"https://zh.wikipedia.org/wiki/%E4%B8%AD%E8%8F%AF%E6%B0%91%E5%9C%8B\">中華民國</a><a title=\"國民政府\" href=\"https://zh.wikipedia.org/wiki/%E5%9C%8B%E6%B0%91%E6%94%BF%E5%BA%9C\">國民政府</a>派遣軍隊武力鎮壓。1945年10月，日本在<a title=\"第二次世界大戰\" href=\"https://zh.wikipedia.org/wiki/%E7%AC%AC%E4%BA%8C%E6%AC%A1%E4%B8%96%E7%95%8C%E5%A4%A7%E6%88%B0\">第二次世界大戰</a><a title=\"日本投降\" href=\"https://zh.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E6%8A%95%E9%99%8D\">投降</a>後，以<a title=\"陳儀\" href=\"https://zh.wikipedia.org/wiki/%E9%99%B3%E5%84%80\">陳儀</a>為首的<a title=\"臺灣省行政長官公署\" href=\"https://zh.wikipedia.org/wiki/%E8%87%BA%E7%81%A3%E7%9C%81%E8%A1%8C%E6%94%BF%E9%95%B7%E5%AE%98%E5%85%AC%E7%BD%B2\">臺灣省行政長官公署</a>接管臺灣。在政治上，政府施政偏頗、官紀敗壞、政治歧視，多數臺灣籍菁英被排拒在外；在經濟上，<a title=\"計劃經濟\" href=\"https://zh.wikipedia.org/wiki/%E8%A8%88%E5%8A%83%E7%B6%93%E6%BF%9F\">計劃經濟</a>政策造成<a title=\"通貨膨脹\" href=\"https://zh.wikipedia.org/wiki/%E9%80%9A%E8%B4%A7%E8%86%A8%E8%83%80\">通貨膨脹</a>與經濟危機，失業人口擴大，社會問題叢生；在文化上，戰後臺灣與中國大陸存在明顯隔閡，受<a title=\"日本化\" href=\"https://zh.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E5%8C%96\">日本化</a>影響的臺灣人被指責是「奴化」，而被要求「中國化」。臺灣民眾對政府的不滿情緒逐漸累積，官民矛盾與族群矛盾更導致緊張情勢持續升高。</p>', '[\"戒嚴\",\"白色恐怖\",\"陳菊\"]', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/228_Incident_h.jpg/450px-228_Incident_h.jpg', 'event', 'et', '1947-02-27', 0),
(40, '西來庵事件', 2, 21, '西來庵事件', '<p>西來庵事件，又稱余清芳事件、玉井事件、噍吧哖事件，是發生於臺灣日治時期大正四年（1915年）的武力抗日事件，領導人為余清芳、羅俊、江定等人，是臺灣日治時期諸多起事之中規模最大、犧牲人數最多的一次同時也是臺灣人（主要為漢族閩南人與原住民族大武壠族）第一次以宗教力量大規模武力抗日的重要事件。</p>\n<p>事件名稱 因為策劃起事的地點在西來庵五福王爺廟，故日方稱以「西來庵事件」，起事的首領是余清芳，故又稱「余清芳事件」；又由余清芳等人與日軍在噍吧哖（今臺南市玉井區）交戰，故亦稱「噍吧哖事件」或「玉井事件」。</p>\n<p>&nbsp;</p>\n<p>事件背景清代時，中臺灣與南臺灣有數千家「自營糖廍」，自行買賣甘蔗且自產自銷砂糖。也有許多小樟腦商，他們招募工人，帶著工具，就自行上山開採。但日本時代，甘蔗全被日本人的糖廠給托拉斯收購，山林地區只要沒有權狀或其他產權証明，將全部變成國有地，禁止私人開採樟腦。許多人對日本人開始不滿。加之1913與1914年期間，臺灣爆發兩次嚴重的颱風災情，白米跟砂糖價格都飆漲。剽悍的噍吧哖農民，本來就常練習宋江陣、舞獅等武術陣頭，民間時常械鬥，種下了舉事的因子。</p>', '[\"123\",\"1234456\",\"123444\"]', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/%E4%BD%99%E6%B8%85%E8%8A%B3%E7%B4%80%E5%BF%B5%E7%A2%91.JPG/330px-%E4%BD%99%E6%B8%85%E8%8A%B3%E7%B4%80%E5%BF%B5%E7%A2%91.JPG', 'event', 'et', '1915-07-06', 1),
(41, '西來庵事件', 2, 21, '西來庵事件', '<p>西來庵事件，又稱余清芳事件、玉井事件、噍吧哖事件[註 1][2][3]，是發生於臺灣日治時期大正四年（1915年）的武力抗日事件，領導人為余清芳、羅俊、江定等人，是臺灣日治時期諸多起事之中規模最大、犧牲人數最多的一次[4]，同時也是臺灣人（主要為漢族閩南人與原住民族大武壠族[5]）第一次以宗教力量大規模武力抗日的重要事件。</p>\n<p>&nbsp;</p>\n<p>事件名稱</p>\n<p>&nbsp;</p>\n<p>因為策劃起事的地點在西來庵五福王爺廟，故日方稱以「西來庵事件」，起事的首領是余清芳，故又稱「余清芳事件」；又由余清芳等人與日軍在噍吧哖（今臺南市玉井區）交戰，故亦稱「噍吧哖事件」或「玉井事件」[6][7]。</p>\n<p>&nbsp;</p>\n<p>事件經過</p>\n<p>臺南西來庵：余清芳宣揚其抗日行動處，原本在臺南市亭仔腳街（今日青年路121號）附近</p>\n<p>事件背景</p>\n<p>&nbsp;</p>\n<p>清代時，中臺灣與南臺灣有數千家「自營糖廍」，自行買賣甘蔗且自產自銷砂糖。也有許多小樟腦商，他們招募工人，帶著工具，就自行上山開採。但日本時代，甘蔗全被日本人的糖廠給托拉斯收購，山林地區只要沒有權狀或其他產權証明，將全部變成國有地，禁止私人開採樟腦。許多人對日本人開始不滿。加之1913與1914年期間，臺灣爆發兩次嚴重的颱風災情，白米跟砂糖價格都飆漲。剽悍的噍吧哖農民，本來就常練習宋江陣、舞獅等武術陣頭，民間時常械鬥，種下了舉事的因子。[8]</p>', '[\"噍吧哖事件\",\"玉井事件\",\"余清芳\"]', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/%E4%BD%99%E6%B8%85%E8%8A%B3%E7%B4%80%E5%BF%B5%E7%A2%91.JPG/330px-%E4%BD%99%E6%B8%85%E8%8A%B3%E7%B4%80%E5%BF%B5%E7%A2%91.JPG', 'event', 'et', '1915-07-06', 0),
(42, '書籍', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'et', NULL, 0),
(43, '讓自己快樂', 1, 42, '讓自己快樂，沒有放不下的情緒，只有不肯放下的你', '<h1 style=\"line-height: 2;\"><span style=\"font-size: 14pt;\">我想把這本書的主旨放在 REBT 的 ABC，那 REBT 是什麼ㄋ</span></h1>\n<p style=\"line-height: 2;\"><span style=\"font-size: 12pt;\">理情行為治療 （REBT, rational emotive behavior therapy），簡單的說，一開始你有個目標（Goal, G\'s），然後你常會遭遇促發事件或逆境（A\'s），阻礙或妨礙了這些目標，所以，發展的過程如以下：</span></p>\n<blockquote>\n<p>A（促發事件或逆境，Activating Event or Adversity）：例如，你想要在學業、工作、運動或感情中獲得成功，結果失敗了。</p>\n<p>B（信念，Beliefs）：尤其是非理性信念，一股腦兒就覺得自己會失敗或被拒絕。例如，「我一定不能失敗，我必須被錄取，失敗太糟糕了；我被拒絕了真是沒用。」</p>\n<p>C（結果，Consequences）：因為逆境和非理性信念而產生的情緒和行為結果。例如：嚴重焦慮和憂鬱的感受。退縮、放棄目標等自我挫敗的行為。例如：退選課程、沒有努力找工作、退出某項運動，拒絕社交。</p>\n</blockquote>\n<p style=\"line-height: 2;\">從Ａ到Ｃ的過程，當然也會有信念（Ｂ），只是已經變成一種自動模式（Autopilot），在過程中你並不會特別思考你的信念是什麼。</p>\n<p style=\"line-height: 2;\">要達到健康的改變，主要是藉由前進到<em>駁斥（Disputing）</em></p>\n<blockquote>\n<p>Ｄ（駁斥，Disputing）：這些不好的信念，被稱為<em>非理性信念</em>，藉由駁斥非理性信念，直到將其轉為健康的理性信念。</p>\n</blockquote>\n<p style=\"line-height: 2;\">駁斥方法有以下三種：</p>\n<ol>\n<li>合乎現實或經驗上的駁斥</li>\n<li>合乎邏輯的駁斥</li>\n<li>合乎實際面或務實的駁斥</li>\n</ol>\n<p style=\"line-height: 2;\">簡單來講就是，信念<strong>是否有證據證明可信</strong>、<strong>這個信念是否合乎邏輯</strong>、<strong>相信這個信念有什麼好處</strong>？可以透過這三個方法去駁斥你的非理性信念，那什麼是<strong>非理性信念</strong>？</p>\n<ol>\n<li>我一定要表現良好，贏得別人的讚賞，不然我就是不夠格的人</li>\n<li>別人一定要友好公平的對待我，不然他們就爛透了</li>\n<li>事情一定要是我想要的樣子，不然這世界就壞到極點了</li>\n</ol>\n<p style=\"line-height: 2;\">非理性信念常常也會有『我應該』、『我絕對要』、『我一定要』、『我必須』諸如此類的抱怨類型，所以當你自我察覺到，就可以試著駁斥你的非理性信念，接著就會得到Ｅ（有效的哲學觀，Effect），書上是這樣稱呼的啦。</p>\n<p style=\"line-height: 2;\">延伸聆聽：<a href=\"https://www.youtube.com/watch?v=1F9sIsGB2mQ&amp;ab_channel=%E5%95%9F%E9%BB%9E%E6%96%87%E5%8C%96\" target=\"_blank\" rel=\"noopener\"><span style=\"font-size: 12pt;\">認知行為治療6-1｜【心理小學堂#32】</span></a></p>\n<h3 style=\"line-height: 2;\">測試一下</h3>', NULL, NULL, 'normal', 'et', NULL, 0);

-- --------------------------------------------------------

--
-- 資料表結構 `event`
--

CREATE TABLE `event` (
  `e_id` int(11) NOT NULL,
  `e_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `e_content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `e_tags` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `e_image_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `e_datetime` datetime NOT NULL,
  `e_account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `settingimage`
--

CREATE TABLE `settingimage` (
  `s_id` int(11) NOT NULL,
  `s_url` longtext NOT NULL,
  `s_account` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `settingimage`
--

INSERT INTO `settingimage` (`s_id`, `s_url`, `s_account`) VALUES
(2, 'https://i.imgur.com/7XPLuTL.jpg\nhttps://memeprod.ap-south-1.linodeobjects.com/user-maker/f28c7d84a4131b825d147011b9247e48.gif\nhttps://s.yimg.com/os/creatr-uploaded-images/2021-02/6e1a47d0-7705-11eb-b73e-9d36f73b0c42\n', 'et');

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

CREATE TABLE `users` (
  `u_id` int(11) NOT NULL,
  `u_account` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `u_password` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `u_token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `u_creat_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`u_id`, `u_account`, `u_password`, `u_token`, `u_creat_at`) VALUES
(17, 'et', 'f056b8cae37dc3ed60ee52da9a2951f8a6c531fe3222a3ad6835dbdd905c7d2a', 'f96ede33bd23d931830034747d59e4ae', '2023-11-03 17:37:03');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `articlecontents`
--
ALTER TABLE `articlecontents`
  ADD PRIMARY KEY (`a_id`);

--
-- 資料表索引 `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`e_id`);

--
-- 資料表索引 `settingimage`
--
ALTER TABLE `settingimage`
  ADD PRIMARY KEY (`s_id`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`u_id`),
  ADD KEY `u_account` (`u_account`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `articlecontents`
--
ALTER TABLE `articlecontents`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `event`
--
ALTER TABLE `event`
  MODIFY `e_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `settingimage`
--
ALTER TABLE `settingimage`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `users`
--
ALTER TABLE `users`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
