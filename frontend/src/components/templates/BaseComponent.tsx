// components need specific usage contracts
// defined via properties (props) interfaces.
export interface IBaseComponentProps {
  sampleTextProp: string;
}

// strongly-typed components that accept well-defined
// contracts can respond to changes much more effectivelly
// alerting developers about errors and enabling unit testing
const BaseComponent: React.FC<IBaseComponentProps> = ({ sampleTextProp }) => {
  return <div>{sampleTextProp}</div>;
};

export default BaseComponent;
