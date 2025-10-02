# P0nni Scenes Manager

Um sistema de gerenciamento de cenas modular para Godot Engine, projetado para rastrear a posição do jogador, gerenciar transições suaves entre cenas (2D e 3D) e identificar áreas específicas dentro de cada mapa.

## ✨ Recursos

* **Modularidade 2D/3D:** Gerenciadores separados (`ScenesManager2D`, `ScenesManager3D`) para lidar com as lógicas específicas de cada dimensão.
* **Detecção Simplificada de Área:** Os nós `Scene2DArea` e `Scene3DArea` agora dependem da **Collision Mask** do Godot para detectar o jogador, eliminando código complexo de cálculo de *bit* de *layer*.
* **Rastreamento de Posição:** Salva a posição e a rotação do jogador ao sair de uma cena, permitindo que o jogador retorne ao ponto exato em que saiu.
* **Configuração de Cena:** Os nós `Scene2DConfig` (e `Scene3DConfig`) servem como a raiz de cada cena, definindo áreas de transição e um ponto de partida (`start_point`).

## ⚙️ Instalação

1.  Copie a pasta do plugin (contendo `plugin.cfg` e todos os scripts `.gd`) para a pasta `addons/p0nni_scenes_manager` do seu projeto Godot.
2.  Vá em **Projeto -> Configurações do Projeto... -> Plugins** e ative o **P0nni Scenes Manager**. O script principal (`p0nni_scenes_manager.gd`) registrará automaticamente os *autoloads* globais (`ScenesManager2D` e `ScenesManager3D`).

## 🗺️ Como Usar

### 1. Configurando sua Cena

O nó raiz da sua cena deve herdar de uma das classes de configuração:
* Para Cenas 2D, defina o nó raiz para estender a classe **`Scene2DConfig`**.
* Para Cenas 3D, defina o nó raiz para estender a classe **`Scene3DConfig`**.

Preencha as variáveis *exportadas* no Inspector:
* **`scene_name`**: Um nome único para sua cena (ex: "Casa_Principal", "Caverna_Norte").
* **`start_point`**: Um nó `Node2D` (ou `Node3D`) que define a posição padrão de *spawn* na cena.
* **`scene_areas`**: Um *Array* dos nós **`Scene2DArea`** (ou `Scene3DArea`) presentes na cena.

### 2. Configurando as Áreas de Transição

Use os nós customizados para definir zonas de transição/evento.

1.  Adicione nós **`Scene2DArea`** (para 2D) ou **`Scene3DArea`** (para 3D) em sua cena.
2.  Preencha a variável *exportada*:
    * **`area_name`**: Um nome único para a área (ex: "Saida_para_Floresta", "Entrada_Caminho").
3.  **Configuração de Colisão (Crucial):**
    * Selecione o nó da área.
    * Em **Collision -> Collision Mask**, **ative apenas o *layer* de colisão** que o seu **nó de Jogador** está usando em seu **Collision Layer**. A área só detectará corpos (como o jogador) que correspondam a essa máscara.

### 3. Utilizando os Gerenciadores (AutoLoads)

Os seguintes *autoloads* (Singletons) são adicionados ao seu projeto para gerenciamento global:

| Manager | Foco | Variável Essencial | Acesso Global no Código |
| :--- | :--- | :--- | :--- |
| `scenes_2d_manager.gd` | Gerencia `Scene2DConfig` e transições 2D. | `@export var player_node_name: String`| `ScenesManager2D` |
| `scenes_3d_manager.gd` | Gerencia `Scene3DConfig` e transições 3D. | `@export var player_node_name: String` | `ScenesManager3D` |

#### Sinais Úteis (ScenesManager2D)

O `ScenesManager2D` (e o 3D correspondente) emite sinais importantes:
* [cite_start]`exit_scene`: Emitido antes de o Godot descarregar a cena anterior[cite: 10].
* [cite_start]`enter_scene(scene_name: String)`: Emitido após a nova cena ser carregada e o `Scene2DConfig` for inicializado[cite: 10, 11, 12].

---
