const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/decorators/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    fontFamily: {
      serif: ['DM Serif Display', ...defaultTheme.fontFamily.serif],
      sans: ['DM Sans', ...defaultTheme.fontFamily.sans],
    },
    extend: {
       colors: {
        'light-sky': "#f0f9ff",
        'main-sky': "#0ea5e9", 
        'orange-accent': "#FFC533",
        'dark-blue': "#02263c"
      },
      spacing: {
        '8xl': '96rem',
        '9xl': '128rem',
      },
      borderRadius: {
        '4xl': '2rem',
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
