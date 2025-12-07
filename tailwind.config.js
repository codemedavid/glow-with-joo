/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Minimalist Modern Theme
        'theme-bg': '#F1EFE7',      // Cream/Base
        'theme-text': '#1E1E1E',    // Charcoal/Dark
        'theme-accent': '#6DA8A1',  // Teal
        'theme-secondary': '#C38E70', // Terracotta

        // Mapping standard colors to the new theme for compatibility
        primary: {
          50: '#F1EFE7',
          100: '#EAE8DE',
          200: '#DDDBCF',
          300: '#C38E70', // Using secondary as a mid-tone
          400: '#9B7460',
          500: '#1E1E1E', // Using dark as primary
          600: '#1A1A1A',
          700: '#151515',
          800: '#101010',
          900: '#000000',
        },
        // Deprecating gold but mapping to secondary/accent to prevent breaks
        gold: {
          50: '#F1EFE7',
          100: '#E0F0EE', // Light teal tint
          200: '#BFE0DC',
          300: '#9BCEC7',
          400: '#6DA8A1', // Accent
          500: '#C38E70', // Secondary
          600: '#A8795E',
          700: '#8D644D',
          800: '#724F3C',
          900: '#1E1E1E',
        },
        accent: {
          light: '#9BCEC7',
          DEFAULT: '#6DA8A1',
          dark: '#588D87',
          white: '#ffffff',
          black: '#1E1E1E',
        },
      },
      fontFamily: {
        inter: ['Inter', 'sans-serif'],
      },
      boxShadow: {
        'soft': '0 2px 10px rgba(0, 0, 0, 0.03)',
        'medium': '0 4px 15px rgba(0, 0, 0, 0.05)',
        'hover': '0 8px 25px rgba(0, 0, 0, 0.08)',
      },
      animation: {
        'fadeIn': 'fadeIn 0.5s ease-out',
        'slideIn': 'slideIn 0.4s ease-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0', transform: 'translateY(5px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        slideIn: {
          '0%': { opacity: '0', transform: 'translateX(-10px)' },
          '100%': { opacity: '1', transform: 'translateX(0)' },
        },
      },
    },
  },
  plugins: [],
}
