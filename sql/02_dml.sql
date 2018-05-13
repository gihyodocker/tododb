INSERT INTO todo(`title`, `content`, `status`, `created`, `updated`) VALUES
('MySQLのDockerイメージを作成する','MySQLのMaster、Slaveそれぞれで利用できるように、環境変数で役割を制御できるMySQLイメージを作成する', 'DONE', NOW(), NOW()),
('MySQLのStackを構築する','MySQLのMaster、SlaveそれぞれのServiceから成るスタックをSwarmクラスタに構築する', 'DONE', NOW(), NOW()),
('APIを実装する','Go言語でTODOの参照・更新処理を行うためのAPIを実装する', 'PROGRESS', NOW(), NOW()),
('NginxのDockerイメージを作成する','バックエンドにHTTPリクエストを流すNginxのイメージを作成する', 'PROGRESS', NOW(), NOW()),
('APIのStackを構築する','NginxとAPIから成るスタックをSwarmクラスタに構築する', 'PROGRESS', NOW(), NOW()),
('Webを実装する','Nuxt.jsを使用して、APIと連携したTODOの状態を表示するWebアプリケーションを実装する', 'PROGRESS', NOW(), NOW()),
('WebのStackを構築する','NginxとWebから成るスタックをSwarmクラスタに構築する', 'PROGRESS', NOW(), NOW()),
('Ingressを構築する','Swarmクラスタに外からアクセスするためのIngressを構築する', 'TODO', NOW(), NOW());

