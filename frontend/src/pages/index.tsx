import type { NextPage } from 'next';
import tw from 'twin.macro';

const Container = tw.div`
  flex 
  flex-col 
  w-full 
  justify-center`;

const Home: NextPage = () => {
  return (
    <Container>
      <button
        onClick={() => {
          // console.log('click');
        }}
      >
        Test
      </button>
    </Container>
  );
};

export default Home;
