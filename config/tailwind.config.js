const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        // Configure your color palette here
        red: '#be123c',
        purple: '#9333ea',
        transparent: 'transparent',
        current: 'currentColor',
        white: '#ffffff',
        purple: '#3f3cbb',
        midnight: '#000000cc',
        metal: '#565584',
        tahiti: '#3ab7bf',
        silver: '#eeeeee',
        bubble: '#5fb523',
        bermuda: '#EFEFEF',
        bermuda1: '#d4d4d4',
        blue: '#3778c2',
        darkblue: '#0a5bb8',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
};
