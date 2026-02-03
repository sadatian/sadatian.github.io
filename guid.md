# Project Structure & Design Guide

This document explains the structure of your Jekyll portfolio project and how to customize its design and content.

## 📂 Key Directories

*   **`_data/`**: Contains `data.yml`, which holds **all** your profile information (career, education, skills, etc.). This is the primary file you will edit for content.
*   **`_sass/`**: Contains the styling rules (SCSS).
    *   **`_base.scss`**: The core styles for HTML elements, **Fonts**, and layout.
    *   **`skins/`**: Defines color themes (e.g., `_blue.scss`, `_ceramic.scss`).
*   **`assets/`**: Contains static files.
    *   `assets/css/`: Contains `main.scss` which imports the skins and base styles.
    *   `assets/images/`: Where you should put your profile picture (`profile3.png`).
*   **`_includes/`**: Reusable HTML components (e.g., `sidebar.html`, `footer.html`, `head.html`).
*   **`_config.yml`**: Global site settings (URL, theme selection, Google Analytics).

---

## 🎨 How to Customize Design

### 1. Changing the **Font Family**
To change the font for the entire project, you need to edit **`_sass/_base.scss`**.

*   **Step 1:** Open `_sass/_base.scss`.
*   **Step 2:** At the very top (Line 3), you will see the Google Fonts import:
    ```scss
    @import url('https://fonts.googleapis.com/css2?family=Fira+Sans+Condensed:ital,wght@0,400;0,600;1,400&display=swap');
    ```
    Replace this URL with the one for your new font from [Google Fonts](https://fonts.google.com/).
*   **Step 3:** Update the `body` style (around Line 6):
    ```scss
    body {
      font-family: "Roboto", sans-serif; /* CHANGE THIS to your new font name */
      /* ... */
    }
    ```

### 2. Changing the **Color Theme**
*   **Option A (Preset Schemes):** Open `_config.yml` and look for `theme_skin`. You can change it to: `blue`, `turquoise`, `green`, `berry`, `orange`, or `ceramic`.
*   **Option B (Custom Colors):**
    1.  Go to `_sass/skins/`.
    2.  Open the file corresponding to your current theme (e.g., `_ceramic.scss` if `theme_skin` is `ceramic`).
    3.  Edit the `$theme-color` variable to your preferred Hex color code.

### 3. Layout Changes
*   If you need to move the sidebar or change the order of sections in the sidebar, edit **`_includes/sidebar.html`**.
*   If you want to add/remove sections from the main content area layout, edit **`index.html`** (or `_layouts/home.html` if it exists, though in this project `index.html` often acts as the main layout structure).

---

## 📝 Updating Content
*   **Profile/Resume**: Edit **`_data/data.yml`**.
*   **Sidebar Toggle**: You can turn sections on/off in the `sidebar` block of `data.yml` (e.g., `about: False`).
