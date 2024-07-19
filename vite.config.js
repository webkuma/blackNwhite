import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  base: './',
  plugins: [
    vue(),
  ],
  // https://israynotarray.com/nodejs/20230407/1216067379/
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:80/blackNwhite/backend',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''),
        configure: (proxy, options) => {
          proxy.on('proxyReq', (proxyReq, req) => {
            console.log('Sending Request to the Target:', req.method, options.target + proxyReq.path);
          });

          proxy.on('proxyRes', (proxyRes, req) => {
            console.log('Receiving Response from the Target:', req.method, options.target + req.url);
          });

          proxy.on('error', (err) => {
            console.log('Error Occurred:', err);
          });
        }
      },
    },
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
