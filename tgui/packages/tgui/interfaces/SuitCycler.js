import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, Dropdown, NumberInput, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const SuitCycler = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    active,
    locked,
    uv_active,
  } = data;

  let subTemplate = <SuitCyclerContent />;

  if (uv_active) {
    subTemplate = <SuitCyclerUV />;
  } else if (locked) {
    subTemplate = <SuitCyclerLocked />;
  } else if (active) {
    subTemplate = <SuitCyclerActive />;
  }

  return (
    <Window
      width={320}
      height={400}
      resizable>
      <Window.Content>
        {subTemplate}
      </Window.Content>
    </Window>
  );
};

const SuitCyclerContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    safeties,
    occupied,
    suit,
    helmet,
    departments,
    species,
    uv_level,
    max_uv_level,
    can_repair,
    damage,
  } = data;

  return (
    <Fragment>

      <Section
        title="Хранилище"
        buttons={(
          <Button
            icon="lock"
            content="Закр."
            onClick={() => act("lock")} />
        )}>
        {!!(occupied && safeties) && (
          <NoticeBox>
            Биологическая сущность обнаружена в камере скафандра. Пожалуйста, снимите его,
            прежде чем продолжить работу.
            <Button
              fluid
              icon="eject"
              color="red"
              content="Извлечь"
              onClick={() => act("eject_guy")} />
          </NoticeBox>
        )}
        <LabeledList>
          <LabeledList.Item label="Шлем">
            <Button
              icon={helmet ? 'square' : 'square-o'}
              content={helmet || 'Пусто'}
              disabled={!helmet}
              onClick={() => act('dispense', {
                item: 'helmet',
              })} />
          </LabeledList.Item>
          <LabeledList.Item label="Костюм">
            <Button
              icon={suit ? 'square' : 'square-o'}
              content={suit || 'Пусто'}
              disabled={!suit}
              onClick={() => act('dispense', {
                item: 'suit',
              })} />
          </LabeledList.Item>
          {can_repair && damage ? (
            <LabeledList.Item label="Suit Damage">
              {damage}
              <Button
                icon="wrench"
                content="Repair"
                onClick={() => act("repair_suit")} />
            </LabeledList.Item>
          ) : null}
        </LabeledList>
      </Section>
      <Section title="Настройка">
        <LabeledList>
          <LabeledList.Item label="Покрас">
            <Dropdown
              noscroll
              width="100%"
              options={departments}
              selected={departments[0]}
              onSelected={val => act("department", { department: val })} />
          </LabeledList.Item>
          <LabeledList.Item label="Раса">
            <Dropdown
              width="100%"
              maxHeight="160px"
              options={species}
              selected={species[0]}
              onSelected={val => act("species", { species: val })} />
          </LabeledList.Item>
        </LabeledList>
        <Button
          mt={1}
          fluid
          content="Перестроить"
          onClick={() => act("apply_paintjob")} />
      </Section>
      <Section title="Рад. обеззараживание">
        <LabeledList>
          <LabeledList.Item label="Уровень рад.">
            <NumberInput
              width="50px"
              value={uv_level}
              minValue={1}
              maxValue={max_uv_level}
              stepPixelSize={30}
              onChange={(e, val) => act("radlevel", { radlevel: val })} />
          </LabeledList.Item>
          <LabeledList.Item label="Обеззараживание">
            <Button
              fluid
              icon="recycle"
              disabled={occupied && safeties}
              textAlign="center"
              onClick={() => act('uv')} />
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Fragment>
  );
};

const SuitCyclerUV = (props, context) => {
  return (
    <NoticeBox>
      Содержимое в настоящее время обеззараживается. Пожалуйста подождите.
    </NoticeBox>
  );
};

const SuitCyclerLocked = (props, context) => {
  const { act, data } = useBackend(context);
  
  const {
    model_text,
    userHasAccess,
  } = data;

  return (
    <Section title="Locked" textAlign="center">
      <Box color="bad" bold>
        Циклер {model_text} костюма в настоящее время заблокирован.
        Пожалуйста, свяжитесь с вашим системный администратор.
      </Box>
      <Box>
        <Button
          icon="unlock"
          content="[Откр.]"
          disabled={!userHasAccess}
          onClick={() => act("lock")} />
      </Box>
    </Section>
  );
};

const SuitCyclerActive = (props, context) => {
  return (
    <NoticeBox>
      Содержимое в настоящее время окрашивается. Пожалуйста подождите.
    </NoticeBox>
  );
};