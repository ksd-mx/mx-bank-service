import { store } from '@/redux/store';
import '@/styles/globals.css';
import { SessionProvider } from 'next-auth/react';
import type { AppProps } from 'next/app';
import { Provider as ReduxProvider } from 'react-redux';

function App({ Component, pageProps }: AppProps) {
  return (
    <ReduxProvider store={store}>
      <SessionProvider session={pageProps.session}>
        <Component {...pageProps} />
      </SessionProvider>
    </ReduxProvider>
  );
}

export default App;
