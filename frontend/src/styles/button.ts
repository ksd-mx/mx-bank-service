import tw from 'twin.macro';

const ButtonElement = tw.button`
    flex
    flex-wrap
    bg-black
    text-white
    w-1/6
    h-20 
    items-center 
    justify-center 
    border
    border-black
    hover:cursor-pointer 
    hover:bg-white
    hover:text-black
    hover:font-bold`;

export default ButtonElement;
